import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tvk_grievance/app/providers.dart';

import 'package:tvk_grievance/app/router/app_routes.dart';
import 'package:tvk_grievance/l10n/app_localizations.dart';

// Use your actual import paths
import 'package:tvk_grievance/core/network/api_client.dart';

class OtpPage extends ConsumerStatefulWidget {
  final String mobileNumber;

  const OtpPage({
    super.key,
    required this.mobileNumber,
  });

  @override
  ConsumerState<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends ConsumerState<OtpPage> {
  final List<TextEditingController> otpControllers =
      List.generate(
    6,
    (index) => TextEditingController(),
  );

  final List<FocusNode> focusNodes =
      List.generate(
    6,
    (index) => FocusNode(),
  );

  Timer? timer;

  int seconds = 30;

  bool canResend = false;

  bool isLoading = false;

  late ApiClient apiClient;

  @override
  void initState() {
    super.initState();

    startTimer();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        FocusScope.of(context).requestFocus(
          focusNodes[0],
        );
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    apiClient = ref.read(apiClientProvider);
  }

  // ============================================================
  // TIMER
  // ============================================================

  void startTimer() {
    timer?.cancel();

    setState(() {
      seconds = 30;
      canResend = false;
    });

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }

        if (seconds == 0) {
          timer.cancel();

          setState(() {
            canResend = true;
          });
        } else {
          setState(() {
            seconds--;
          });
        }
      },
    );
  }

  // ============================================================
  // GET OTP
  // ============================================================

  String getOtp() {
    return otpControllers
        .map((controller) => controller.text)
        .join();
  }

  // ============================================================
  // FETCH USER AND STORE LOCALLY
  // ============================================================

  Future<void> verifyOtp() async {
    final otp = getOtp();

    if (otp.length != 6) {
      showErrorMessage(
        'Please enter the 6 digit OTP.',
      );
      return;
    }

    if (isLoading) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final mobileNumber = widget.mobileNumber.trim();

      debugPrint(
        'Fetching user for mobile: $mobileNumber',
      );

      // ========================================================
      // GET USER BY MOBILE
      // ========================================================

      final response = await apiClient.get(
        'users/mobile/$mobileNumber',
      );

      debugPrint(
        'USER API STATUS: ${response.statusCode}',
      );

      debugPrint(
        'USER API RESPONSE: ${response.data}',
      );

      if (response.statusCode != 200) {
        throw Exception(
          'Unable to fetch user details.',
        );
      }

      final responseData = response.data;

      if (responseData is! Map) {
        throw Exception(
          'Invalid user response.',
        );
      }

      final userData = responseData['data'];

      if (userData == null ||
          userData is! Map) {
        throw Exception(
          'User details not found.',
        );
      }

      final user = Map<String, dynamic>.from(
        userData,
      );

      // ========================================================
      // GET USER ID
      // ========================================================

      final userId = user['_id']?.toString();

      if (userId == null ||
          userId.isEmpty) {
        throw Exception(
          'User ID not found.',
        );
      }

      // ========================================================
      // STORE IN LOCAL STORAGE
      // ========================================================

      final prefs =
          await SharedPreferences.getInstance();

      // Complete user object
      await prefs.setString(
        'user',
        jsonEncode(user),
      );

      // User ID separately
      await prefs.setString(
        'user_id',
        userId,
      );

      // Optional: store mobile separately too
      await prefs.setString(
        'user_mobile',
        mobileNumber,
      );

      debugPrint(
        'USER SAVED SUCCESSFULLY',
      );

      debugPrint(
        'USER ID: $userId',
      );

      debugPrint(
        'USER: $user',
      );

      if (!mounted) return;

      showSuccessMessage(
        'Login successful.',
      );

      await Future.delayed(
        const Duration(milliseconds: 500),
      );

      if (!mounted) return;

      context.pushReplacement(
        AppRoutes.home,
      );
    } on DioException catch (e) {
      debugPrint(
        'USER API ERROR: ${e.message}',
      );

      debugPrint(
        'USER API STATUS: ${e.response?.statusCode}',
      );

      debugPrint(
        'USER API RESPONSE: ${e.response?.data}',
      );

      if (!mounted) return;

      String message =
          'Unable to fetch user details.';

      final responseData =
          e.response?.data;

      if (responseData is Map) {
        if (responseData['message'] != null) {
          message =
              responseData['message'].toString();
        }
      }

      showErrorMessage(message);
    } catch (e) {
      debugPrint(
        'VERIFY ERROR: $e',
      );

      if (!mounted) return;

      showErrorMessage(
        e.toString().replaceFirst(
              'Exception: ',
              '',
            ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // ============================================================
  // SUCCESS MESSAGE
  // ============================================================

  void showSuccessMessage(
    String message,
  ) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
        .hideCurrentSnackBar();

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior:
            SnackBarBehavior.floating,
      ),
    );
  }

  // ============================================================
  // ERROR MESSAGE
  // ============================================================

  void showErrorMessage(
    String message,
  ) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
        .hideCurrentSnackBar();

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior:
            SnackBarBehavior.floating,
      ),
    );
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    timer?.cancel();

    for (final controller
        in otpControllers) {
      controller.dispose();
    }

    for (final node in focusNodes) {
      node.dispose();
    }

    super.dispose();
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(
    BuildContext context,
  ) {
    final l10n =
        AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration:
            const BoxDecoration(
          gradient:
              LinearGradient(
            colors: [
              Color(0xFFa91145),
              Color(0xffffb300),
            ],
            begin:
                Alignment.topCenter,
            end:
                Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 25,
            ),
            child: Column(
              children: [
                const SizedBox(height: 80),

                Image.asset(
                  "assets/images/tvk_logo.png",
                  height: 100,
                ),

                const SizedBox(height: 30),

                Text(
                  l10n.enterOtp,
                  style:
                      const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  '${l10n.enterOtpSubtitle}\n'
                  '+91 ${widget.mobileNumber}',
                  textAlign:
                      TextAlign.center,
                  style:
                      const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 35),

                // ==================================================
                // OTP BOXES
                // ==================================================

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                  children:
                      List.generate(
                    6,
                    (index) {
                      return SizedBox(
                        height: 55,
                        width: 45,
                        child:
                            TextFormField(
                          controller:
                              otpControllers[
                                  index],
                          focusNode:
                              focusNodes[
                                  index],
                          keyboardType:
                              TextInputType
                                  .number,
                          textAlign:
                              TextAlign.center,
                          maxLength: 1,
                          style:
                              const TextStyle(
                            fontSize: 20,
                            fontWeight:
                                FontWeight
                                    .bold,
                            color:
                                Colors.black,
                          ),
                          cursorHeight: 22,
                          decoration:
                              InputDecoration(
                            counterText:
                                "",
                            filled: true,
                            fillColor:
                                Colors.white,
                            contentPadding:
                                const EdgeInsets
                                    .symmetric(
                              vertical: 12,
                            ),
                            border:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                5,
                              ),
                              borderSide:
                                  BorderSide
                                      .none,
                            ),
                          ),
                          onChanged:
                              (value) {
                            if (value
                                    .isNotEmpty &&
                                index <
                                    5) {
                              FocusScope
                                  .of(
                                context,
                              ).requestFocus(
                                focusNodes[
                                    index +
                                        1],
                              );
                            }

                            if (value
                                    .isEmpty &&
                                index >
                                    0) {
                              FocusScope
                                  .of(
                                context,
                              ).requestFocus(
                                focusNodes[
                                    index -
                                        1],
                              );
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 35),

                // ==================================================
                // VERIFY BUTTON
                // ==================================================

                SizedBox(
                  width:
                      double.infinity,
                  height: 45,
                  child:
                      ElevatedButton(
                    onPressed:
                        isLoading
                            ? null
                            : verifyOtp,
                    style:
                        ElevatedButton
                            .styleFrom(
                      backgroundColor:
                          const Color(
                        0xffc90000,
                      ),
                      disabledBackgroundColor:
                          Colors.grey,
                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius
                                .circular(
                          3,
                        ),
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child:
                                CircularProgressIndicator(
                              color:
                                  Colors.white,
                              strokeWidth:
                                  2.5,
                            ),
                          )
                        : Text(
                            l10n.submit,
                            style:
                                const TextStyle(
                              color:
                                  Colors.white,
                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 20),

                // ==================================================
                // RESEND OTP
                // ==================================================

                GestureDetector(
                  onTap: canResend
                      ? () {
                          startTimer();
                        }
                      : null,
                  child: Text(
                    canResend
                        ? l10n.resendOtp
                        : l10n.resendOtpIn(
                            seconds,
                          ),
                    style:
                        TextStyle(
                      color: canResend
                          ? const Color
                              .fromARGB(
                              255,
                              99,
                              109,
                              255,
                            )
                          : Colors.white70,
                      fontSize: 14,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}