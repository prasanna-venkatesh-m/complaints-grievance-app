import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tvk_grievance/app/providers.dart';
import 'package:tvk_grievance/app/router/app_routes.dart';
import 'package:tvk_grievance/l10n/app_localizations.dart';

// CHANGE THIS IMPORT TO YOUR ACTUAL ApiClient FILE
import 'package:tvk_grievance/core/network/api_client.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();

  final TextEditingController mobileController = TextEditingController();

  final TextEditingController dobController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController areaController = TextEditingController();

  final TextEditingController streetController = TextEditingController();

  bool showValidation = false;
  bool isFormValid = false;
  bool isLoadingWards = false;
  bool isRegistering = false;

  String? selectedGender;

  WardModel? selectedWard;

  List<WardModel> wards = [];

  late ApiClient apiClient;

  @override
  void initState() {
    super.initState();

    // Do not call ref.watch() inside initState.
    // We get the provider in didChangeDependencies.
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    apiClient = ref.read(apiClientProvider);

    if (wards.isEmpty && !isLoadingWards) {
      loadWards();
    }
  }

  @override
  void dispose() {
    fullNameController.dispose();
    mobileController.dispose();
    dobController.dispose();
    emailController.dispose();
    areaController.dispose();
    streetController.dispose();

    super.dispose();
  }

  // ============================================================
  // GET WARDS
  // ============================================================

  Future<void> loadWards() async {
    if (!mounted) return;

    setState(() {
      isLoadingWards = true;
    });

    try {
      final response = await apiClient.get('ward');

      debugPrint('WARD API RESPONSE: ${response.data}');

      final responseData = response.data;

      if (responseData is Map<String, dynamic>) {
        final data = responseData['data'];

        if (data is List) {
          final loadedWards = data
              .whereType<Map>()
              .map(
                (ward) => WardModel.fromJson(Map<String, dynamic>.from(ward)),
              )
              .where((ward) => ward.isActive)
              .toList();

          if (!mounted) return;

          setState(() {
            wards = loadedWards;
          });
        }
      }
    } on DioException catch (e) {
      debugPrint('WARD API ERROR: ${e.message}');
      debugPrint('WARD API RESPONSE: ${e.response?.data}');

      if (!mounted) return;

      showErrorMessage(getDioErrorMessage(e, 'Unable to load wards'));
    } catch (e) {
      debugPrint('WARD ERROR: $e');

      if (!mounted) return;

      showErrorMessage('Unable to load wards. Please try again.');
    } finally {
      if (mounted) {
        setState(() {
          isLoadingWards = false;
        });
      }
    }
  }

  // ============================================================
  // FORM VALIDATION
  // ============================================================

  void checkFormValid() {
    final name = fullNameController.text.trim();
    final mobile = mobileController.text.trim();

    final valid =
        name.isNotEmpty &&
        RegExp(r'^[a-zA-Z ]+$').hasMatch(name) &&
        mobile.length == 10 &&
        dobController.text.isNotEmpty &&
        selectedGender != null &&
        selectedWard != null &&
        areaController.text.trim().isNotEmpty &&
        streetController.text.trim().isNotEmpty;

    if (mounted && isFormValid != valid) {
      setState(() {
        isFormValid = valid;
      });
    }
  }

  // ============================================================
  // DATE PICKER
  // ============================================================

  Future<void> selectDate() async {
    final today = DateTime.now();

    final maxDate = DateTime(today.year - 18, today.month, today.day);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: maxDate,
      firstDate: DateTime(1950),
      lastDate: maxDate,
    );

    if (picked != null) {
      setState(() {
        // API format: yyyy-MM-dd
        dobController.text =
            '${picked.year.toString().padLeft(4, '0')}-'
            '${picked.month.toString().padLeft(2, '0')}-'
            '${picked.day.toString().padLeft(2, '0')}';
      });

      checkFormValid();
    }
  }

  // ============================================================
  // REGISTER USER
  // ============================================================

  Future<void> registerUser() async {
    setState(() {
      showValidation = true;
    });

    final isValid = _formKey.currentState?.validate() == true;

    checkFormValid();

    if (!isValid || !isFormValid) {
      return;
    }

    if (selectedWard == null) {
      showErrorMessage('Please select a ward.');
      return;
    }

    if (isRegistering) {
      return;
    }

    setState(() {
      isRegistering = true;
    });

    try {
      // --------------------------------------------------------
      // Request body
      // --------------------------------------------------------

      final Map<String, dynamic> requestBody = {
        'Name': fullNameController.text.trim(),
        'Mobile': mobileController.text.trim(),
        if (emailController.text.trim().isNotEmpty)
          'Email': emailController.text.trim(),
        'DOB': dobController.text.trim(),
        'Gender': getApiGender(selectedGender!),
        'WardId': selectedWard!._id,
        'Area': areaController.text.trim(),
        'Street': streetController.text.trim(),
        'Role': 'CITIZEN',
        'IsActive': true,
      };

      debugPrint('REGISTER REQUEST: $requestBody');

      final response = await apiClient.post('users', data: requestBody);

      debugPrint('REGISTER RESPONSE STATUS: ${response.statusCode}');
      debugPrint('REGISTER RESPONSE DATA: ${response.data}');

      if (!mounted) return;

      // Usually 200 or 201 means successful creation.
      if (response.statusCode == 200 || response.statusCode == 201) {
        showSuccessMessage('Registration successful.');

        // Small delay so user can see success message.
        await Future.delayed(const Duration(milliseconds: 700));

        if (!mounted) return;

        context.push(AppRoutes.login);
      } else {
        showErrorMessage('Registration failed. Please try again.');
      }
    } on DioException catch (e) {
      debugPrint('REGISTER API ERROR: ${e.message}');
      debugPrint('REGISTER API STATUS: ${e.response?.statusCode}');
      debugPrint('REGISTER API RESPONSE: ${e.response?.data}');

      if (!mounted) return;

      showErrorMessage(
        getDioErrorMessage(e, 'Registration failed. Please try again.'),
      );
    } catch (e) {
      debugPrint('REGISTER ERROR: $e');

      if (!mounted) return;

      showErrorMessage('Registration failed. Please try again.');
    } finally {
      if (mounted) {
        setState(() {
          isRegistering = false;
        });
      }
    }
  }

  // ============================================================
  // API GENDER
  // ============================================================

  String getApiGender(String gender) {
    switch (gender) {
      case 'Male':
        return 'MALE';

      case 'Female':
        return 'FEMALE';

      case 'Other':
        return 'OTHER';

      default:
        return gender.toUpperCase();
    }
  }

  // ============================================================
  // ERROR MESSAGE
  // ============================================================

  String getDioErrorMessage(DioException error, String defaultMessage) {
    final responseData = error.response?.data;

    if (responseData is Map) {
      final message = responseData['message'];

      if (message != null && message.toString().trim().isNotEmpty) {
        return message.toString();
      }

      final errorMessage = responseData['error'];

      if (errorMessage != null && errorMessage.toString().trim().isNotEmpty) {
        return errorMessage.toString();
      }
    }

    if (error.response?.statusCode == 400) {
      return 'Invalid registration details.';
    }

    if (error.response?.statusCode == 409) {
      return 'Mobile number or email already exists.';
    }

    if (error.response?.statusCode == 500) {
      return 'Server error. Please try again later.';
    }

    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout) {
      return 'Connection timed out. Please try again.';
    }

    if (error.type == DioExceptionType.connectionError) {
      return 'Unable to connect to server. Please check your internet connection.';
    }

    return defaultMessage;
  }

  // ============================================================
  // SUCCESS MESSAGE
  // ============================================================

  void showSuccessMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ============================================================
  // ERROR MESSAGE
  // ============================================================

  void showErrorMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFa91145), Color(0xffffb300)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Form(
              key: _formKey,
              autovalidateMode: showValidation
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              child: Column(
                children: [
                  const SizedBox(height: 60),

                  Image.asset("assets/images/tvk_logo.png", height: 100),

                  const SizedBox(height: 20),

                  Text(
                    l10n.welcomeToTvk,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    l10n.createYourAccount,
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),

                  const SizedBox(height: 15),

                  // ==================================================
                  // FULL NAME
                  // ==================================================
                  inputField(
                    Icons.person_outline,
                    l10n.fullName,
                    required: true,
                    controller: fullNameController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return l10n.fullNameRequired;
                      }

                      if (value.trim().length < 3) {
                        return l10n.minimumThreeCharacters;
                      }

                      if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value.trim())) {
                        return l10n.onlyAlphabetsAllowed;
                      }

                      return null;
                    },
                  ),

                  // ==================================================
                  // MOBILE
                  // ==================================================
                  inputField(
                    Icons.phone_android,
                    l10n.mobileNumber,
                    required: true,
                    keyboard: TextInputType.phone,
                    controller: mobileController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.mobileNumberRequired;
                      }

                      if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                        return l10n.invalidMobileNumber;
                      }

                      return null;
                    },
                  ),

                  // ==================================================
                  // DOB
                  // ==================================================
                  GestureDetector(
                    onTap: selectDate,
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: dobController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return l10n.dateOfBirthRequired;
                          }

                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(
                            Icons.calendar_month,
                            color: Colors.grey,
                            size: 20,
                          ),
                          hintText: "${l10n.dateOfBirth} *",
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                          errorStyle: const TextStyle(
                            color: Colors.yellow,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // ==================================================
                  // GENDER
                  // ==================================================
                  genderDropdown(l10n),

                  const SizedBox(height: 10),

                  // ==================================================
                  // EMAIL
                  // ==================================================
                  inputField(
                    Icons.email_outlined,
                    l10n.emailId,
                    controller: emailController,
                    keyboard: TextInputType.emailAddress,
                  ),

                  // ==================================================
                  // WARD
                  // ==================================================
                  wardDropdown(l10n),

                  const SizedBox(height: 10),

                  // ==================================================
                  // AREA
                  // ==================================================
                  inputField(
                    Icons.location_on_outlined,
                    l10n.area,
                    required: true,
                    controller: areaController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return l10n.selectArea;
                      }

                      return null;
                    },
                  ),

                  // ==================================================
                  // STREET
                  // ==================================================
                  inputField(
                    Icons.streetview,
                    l10n.street,
                    required: true,
                    controller: streetController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return l10n.selectStreet;
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 18),

                  // ==================================================
                  // REGISTER BUTTON
                  // ==================================================
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: isRegistering ? null : registerUser,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isFormValid
                            ? const Color(0xffc90000)
                            : Colors.grey,
                        disabledBackgroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      child: isRegistering
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              l10n.register,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ==================================================
                  // LOGIN
                  // ==================================================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        l10n.alreadyHaveAccount,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.push(AppRoutes.login);
                        },
                        child: Text(
                          l10n.login,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // INPUT FIELD
  // ============================================================

  Widget inputField(
    IconData icon,
    String hint, {
    bool required = false,
    TextInputType keyboard = TextInputType.text,
    TextEditingController? controller,
    String? Function(String?)? validator,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboard,
        validator: validator,
        onChanged: (value) {
          checkFormValid();
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(icon, color: Colors.grey, size: 20),
          hintText: required ? "$hint *" : hint,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
          errorStyle: const TextStyle(
            color: Colors.yellow,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // GENDER DROPDOWN
  // ============================================================

  Widget genderDropdown(AppLocalizations l10n) {
    final genders = {
      "Male": l10n.male,
      "Female": l10n.female,
      "Other": l10n.otherGender,
    };

    return FormField<String>(
      validator: (value) {
        if (selectedGender == null) {
          return l10n.genderRequired;
        }

        return null;
      },
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 48,
              margin: const EdgeInsets.only(bottom: 4),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.people_outline,
                    color: Colors.grey,
                    size: 20,
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedGender,
                        hint: Text(
                          "${l10n.gender} *",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                        isExpanded: true,
                        items: genders.entries.map((entry) {
                          return DropdownMenuItem<String>(
                            value: entry.key,
                            child: Text(entry.value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value;
                          });

                          field.didChange(value);
                          checkFormValid();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(left: 12, bottom: 8),
                child: Text(
                  field.errorText!,
                  style: const TextStyle(
                    color: Colors.yellow,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  // ============================================================
  // WARD DROPDOWN
  // ============================================================

  Widget wardDropdown(AppLocalizations l10n) {
    return FormField<String>(
      validator: (value) {
        if (selectedWard == null) {
          return l10n.selectWard;
        }

        return null;
      },
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 48,
              margin: const EdgeInsets.only(bottom: 4),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  const Icon(Icons.location_city, color: Colors.grey, size: 20),

                  const SizedBox(width: 12),

                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<WardModel>(
                        value: selectedWard,
                        isExpanded: true,

                        hint: Text(
                          isLoadingWards
                              ? 'Loading ${l10n.ward}...'
                              : '${l10n.ward} *',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),

                        items: wards.map((ward) {
                          return DropdownMenuItem<WardModel>(
                            value: ward,
                            child: Text(
                              Localizations.localeOf(context).languageCode ==
                                      'ta'
                                  ? (ward.wardNameTa ??
                                        ward.wardNameEn ??
                                        '${l10n.ward} ${ward.wardNo}')
                                  : (ward.wardNameEn ??
                                        ward.wardNameTa ??
                                        '${l10n.ward} ${ward.wardNo}'),
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),

                        onChanged: isLoadingWards
                            ? null
                            : (value) {
                                setState(() {
                                  selectedWard = value;
                                });

                                field.didChange(value?._id);

                                checkFormValid();
                              },
                      ),
                    ),
                  ),

                  if (isLoadingWards)
                    const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                ],
              ),
            ),

            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(left: 12, bottom: 8),
                child: Text(
                  field.errorText!,
                  style: const TextStyle(
                    color: Colors.yellow,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

// ================================================================
// WARD MODEL
// ================================================================

class WardModel {
  final String _id;
  final WardName wardName;
  final int wardNo;
  final bool isActive;

  WardModel({
    required String id,
    required this.wardName,
    required this.wardNo,
    required this.isActive,
  }) : _id = id;

  String get id => _id;

  String? get wardNameEn => wardName.en;

  String? get wardNameTa => wardName.ta;

  factory WardModel.fromJson(Map<String, dynamic> json) {
    final wardNameJson = json['WardName'];

    return WardModel(
      id: json['_id']?.toString() ?? '',
      wardName: WardName.fromJson(
        wardNameJson is Map
            ? Map<String, dynamic>.from(wardNameJson)
            : <String, dynamic>{},
      ),
      wardNo: int.tryParse(json['WardNo']?.toString() ?? '') ?? 0,
      isActive: json['IsActive'] == true,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is WardModel && other._id == _id;
  }

  @override
  int get hashCode => _id.hashCode;
}

// ================================================================
// WARD NAME MODEL
// ================================================================

class WardName {
  final String? en;
  final String? ta;

  WardName({this.en, this.ta});

  factory WardName.fromJson(Map<String, dynamic> json) {
    return WardName(en: json['en']?.toString(), ta: json['ta']?.toString());
  }
}
