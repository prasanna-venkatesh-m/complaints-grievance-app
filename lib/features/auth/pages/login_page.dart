import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:tvk_grievance/app/router/app_routes.dart';
import 'package:tvk_grievance/core/shared_widgets/language_button_widget.dart';
import 'package:tvk_grievance/l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController mobileController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isMobileValid = false;

  @override
  void dispose() {
    mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFa91145), Color(0xffF5A623), Color(0xffD84A05)],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Language toggle - top right corner
              const Positioned(top: 10, right: 16, child: LanguageButton()),

              // Login content
              Center(
                child: Transform.translate(
                  offset: const Offset(0, -35),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.07,
                    ),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 420),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "assets/images/tvk_logo.png",
                              width: size.width * 0.30,
                            ),

                            SizedBox(height: size.height * 0.025),

                            Text(
                              l10n.welcomeToTvk,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: size.width * 0.065,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: size.height * 0.035),

                            Text(
                              l10n.loginWithMobileNumber,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: size.width * 0.035,
                              ),
                            ),

                            SizedBox(height: size.height * 0.025),

                            TextFormField(
                              controller: mobileController,
                              keyboardType: TextInputType.phone,
                              maxLength: 10,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              onChanged: (value) {
                                setState(() {
                                  isMobileValid = value.length == 10;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return l10n.mobileNumberRequired;
                                }

                                if (value.length != 10) {
                                  return l10n.invalidMobileNumber;
                                }

                                return null;
                              },
                              decoration: InputDecoration(
                                counterText: "",
                                filled: true,
                                fillColor: Colors.white,
                                hintText: l10n.mobileNumber,
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade600,
                                ),
                                prefixIcon: const Icon(
                                  Icons.phone_android_outlined,
                                ),
                                suffixIcon: Icon(
                                  isMobileValid
                                      ? Icons.check_circle
                                      : Icons.cancel_outlined,
                                  color: isMobileValid
                                      ? Colors.green
                                      : Colors.grey,
                                ),
                                errorStyle: const TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: Colors.redAccent,
                                    width: 1.5,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: Colors.redAccent,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: size.height * 0.035),

                            SizedBox(
                              width: double.infinity,
                              height: 55,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFB30000),
                                  disabledBackgroundColor: const Color(
                                    0xFFB30000,
                                  ).withValues(alpha: 0.45),
                                  disabledForegroundColor: Colors.white54,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  elevation: isMobileValid ? 3 : 0,
                                ),
                                onPressed: isMobileValid
                                    ? () {
                                        if (formKey.currentState!.validate()) {
                                          context.push(
                                            AppRoutes.otpPage,
                                            extra: mobileController.text.trim(),
                                          );
                                        }
                                      }
                                    : null,
                                child: Text(
                                  l10n.getOtp,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: size.height * 0.025),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  l10n.dontHaveAccount,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    context.push(AppRoutes.signup);
                                  },
                                  child: Text(
                                    l10n.register,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
