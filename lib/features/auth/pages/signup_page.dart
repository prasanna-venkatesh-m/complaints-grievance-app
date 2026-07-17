import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tvk_grievance/app/router/app_routes.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController constituencyController = TextEditingController();
  bool showValidation = false;
  String? selectedGender;
  String? selectedDistrict;
  bool isFormValid = false;
  final List<String> genders = ["Male", "Female", "Other"];

  final List<String> districts = [
    "Chennai",
    "Coimbatore",
    "Madurai",
    "Salem",
    "Trichy",
    "Tirunelveli",
  ];

  void checkFormValid() {
    final valid =
        fullNameController.text.trim().isNotEmpty &&
        RegExp(r'^[a-zA-Z ]+$').hasMatch(fullNameController.text.trim()) &&
        mobileController.text.trim().length == 10 &&
        dobController.text.isNotEmpty &&
        selectedGender != null &&
        selectedDistrict != null &&
        constituencyController.text.trim().isNotEmpty;

    if (isFormValid != valid) {
      setState(() {
        isFormValid = valid;
      });
    }
  }

  Future<void> selectDate() async {
    DateTime today = DateTime.now();
    DateTime maxDate = DateTime(today.year - 18, today.month, today.day);
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: maxDate,
      firstDate: DateTime(1950),
      lastDate: maxDate,
    );

    if (picked != null) {
      setState(() {
        dobController.text = "${picked.day}-${picked.month}-${picked.year}";
      });
      checkFormValid();
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  const Text(
                    "WELCOME TO TVK",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Create your Account",
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  const SizedBox(height: 15),
                  inputField(
                    Icons.person_outline,
                    "Full Name",
                    required: true,
                    controller: fullNameController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Full Name is required";
                      }
                      if (value.trim().length < 3) {
                        return "Minimum 3 characters required";
                      }
                      if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                        return "Only alphabets allowed";
                      }
                      return null;
                    },
                  ),

                  inputField(
                    Icons.phone_android,
                    "Mobile Number",
                    required: true,
                    keyboard: TextInputType.phone,
                    controller: mobileController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Mobile number required";
                      }
                      if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                        return "Enter valid 10 digit mobile number";
                      }
                      return null;
                    },
                  ),

                  GestureDetector(
                    onTap: selectDate,
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: dobController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Date of Birth is required";
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
                          hintText: "Date of Birth *",
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
                  genderDropdown(),
                  const SizedBox(height: 10),
                  inputField(
                    Icons.email_outlined,
                    "Email Id",
                    controller: emailController,
                  ),
                  searchableDistrictDropdown(),
                  const SizedBox(height: 10),
                  inputField(
                    Icons.account_circle_outlined,
                    "Constituency Number",
                    required: true,
                    controller: constituencyController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Constituency number required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          showValidation = true;
                        });

                        if (_formKey.currentState!.validate() && isFormValid) {
                          // Register API
                          context.push(AppRoutes.login);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isFormValid
                            ? const Color(0xffc90000)
                            : Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),

                      child: const Text( 
                        "Register",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.push(AppRoutes.login);
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
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

  Widget genderDropdown() {
    return FormField<String>(
      validator: (value) {
        if (selectedGender == null) {
          return "Gender is required";
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
                        hint: const Text(
                          "Gender *",
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                        isExpanded: true,
                        items: genders.map((gender) {
                          return DropdownMenuItem(
                            value: gender,
                            child: Text(gender),
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

  Widget searchableDistrictDropdown() {
    return FormField<String>(
      validator: (value) {
        if (selectedDistrict == null) {
          return "District is required";
        }
        return null;
      },
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () async {
                String? result = await showSearch<String>(
                  context: context,
                  delegate: DistrictSearchDelegate(districts),
                );

                if (result != null && result.isNotEmpty) {
                  setState(() {
                    selectedDistrict = result;
                  });

                  field.didChange(result);
                  checkFormValid();
                }
              },
              child: Container(
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
                      Icons.location_city,
                      color: Colors.grey,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        selectedDistrict ?? "District *",
                        style: TextStyle(
                          color: selectedDistrict == null
                              ? Colors.grey
                              : Colors.black,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const Icon(Icons.search, color: Colors.grey, size: 20),
                  ],
                ),
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

class DistrictSearchDelegate extends SearchDelegate<String> {
  final List<String> districts;

  DistrictSearchDelegate(this.districts);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = "";
          },
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, "");
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final results = districts.where((item) {
      return item.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index]),
          onTap: () {
            close(context, results[index]);
          },
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }
}
