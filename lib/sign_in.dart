import 'package:cleansafi/color_pallette.dart';
import 'package:cleansafi/responsive_layout_builder.dart';
import 'package:cleansafi/services_offered.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:another_flushbar/flushbar.dart';

class SignInDialog extends StatelessWidget {
  const SignInDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      small: (_, __) => MobileSignInDialog(
        key: const Key('mobile_dialog'),
      ),
      large: (_, __) => SizedBox.shrink(
        key: const Key('web_dialog'),
      ),
    );
  }
}

class MobileSignInDialog extends StatefulWidget {
  const MobileSignInDialog({super.key});

  @override
  State<MobileSignInDialog> createState() => _MobileSignInDialogState();
}

class _MobileSignInDialogState extends State<MobileSignInDialog> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _signInWithEmailAndPassword() async {
    try {
      // Get email and password from text fields
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      // Validate input fields
      if (email.isEmpty || password.isEmpty) {
        Flushbar(
          messageText: Text(
            "please fill in all fields",
            style: const TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.normal,
              color: AppTheme.kDarkErrorColor,
              fontWeight: FontWeight.w500,
              fontFamily: 'Helvetica Neue',
            ),
          ),
          backgroundColor: AppTheme.kSecondaryErrorColor,
          boxShadows: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 4,
              offset: const Offset(0, 4.5),
            ),
          ],
          borderRadius: BorderRadius.circular(12),
          margin: const EdgeInsets.fromLTRB(16, 20, 16, 0), // Same top margin
          flushbarPosition: FlushbarPosition.TOP,
          duration: const Duration(seconds: 3),
          animationDuration: const Duration(milliseconds: 400),
          forwardAnimationCurve: Curves.easeOut,
          reverseAnimationCurve: Curves.easeIn,
          isDismissible: true,
          padding: const EdgeInsets.all(16),
        ).show(context);

        return;
      }

      // Sign in with Firebase
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // If successful, navigate to the home page
      if (userCredential.user != null) {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );

          Flushbar(
            messageText: Text(
              "Successfully signed in!",
              style: const TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.normal,
                color: AppTheme.kSuccessMessageColor,
                fontWeight: FontWeight.w500,
                fontFamily: 'Helvetica Neue',
              ),
            ),
            backgroundColor: AppTheme.kSuccessColor,
            boxShadows: [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 4,
                offset: const Offset(0, 4.5),
              ),
            ],
            borderRadius: BorderRadius.circular(12),
            margin: const EdgeInsets.fromLTRB(16, 20, 16, 0), // Same top margin
            flushbarPosition: FlushbarPosition.TOP,
            duration: const Duration(seconds: 3),
            animationDuration: const Duration(milliseconds: 400),
            forwardAnimationCurve: Curves.easeOut,
            reverseAnimationCurve: Curves.easeIn,
            isDismissible: true,
            padding: const EdgeInsets.all(16),
          ).show(context);
        }
      }
    } on FirebaseAuthException catch (e) {
      // Handle Firebase errors
      String errorMessage = "Sign-in failed. Please try again.";
      if (e.code == 'user-not-found') {
        errorMessage = "No user found with this email.";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Incorrect password.";
      }
      if (mounted) {
        Flushbar(
          messageText: Text(
            errorMessage,
            style: const TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.normal,
              color: AppTheme.kDarkErrorColor,
              fontWeight: FontWeight.w500,
              fontFamily: 'Helvetica Neue',
            ),
          ),
          backgroundColor: AppTheme.kSecondaryErrorColor,
          boxShadows: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 4,
              offset: const Offset(0, 4.5),
            ),
          ],
          borderRadius: BorderRadius.circular(12),
          margin: const EdgeInsets.fromLTRB(16, 20, 16, 0), // Same top margin
          flushbarPosition: FlushbarPosition.TOP,
          duration: const Duration(seconds: 3),
          animationDuration: const Duration(milliseconds: 400),
          forwardAnimationCurve: Curves.easeOut,
          reverseAnimationCurve: Curves.easeIn,
          isDismissible: true,
          padding: const EdgeInsets.all(16),
        ).show(context);
      }
    } catch (e) {
      // Handle other errors
      if (mounted) {
        Flushbar(
          messageText: Text(
            "an unexpected error has occurred",
            style: const TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.normal,
              color: AppTheme.kDarkErrorColor,
              fontWeight: FontWeight.w500,
              fontFamily: 'Helvetica Neue',
            ),
          ),
          backgroundColor: AppTheme.kSecondaryErrorColor,
          boxShadows: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 4,
              offset: const Offset(0, 4.5),
            ),
          ],
          borderRadius: BorderRadius.circular(12),
          margin: const EdgeInsets.fromLTRB(16, 20, 16, 0), // Same top margin
          flushbarPosition: FlushbarPosition.TOP,
          duration: const Duration(seconds: 3),
          animationDuration: const Duration(milliseconds: 400),
          forwardAnimationCurve: Curves.easeOut,
          reverseAnimationCurve: Curves.easeIn,
          isDismissible: true,
          padding: const EdgeInsets.all(16),
        ).show(context);
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 400,
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(8),
        child: Container(
          width: screenWidth * 0.7,
          height: screenWidth * 0.7, // Use initialized width
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppTheme.kBackgroundColor,
          ),
          constraints: BoxConstraints(
            maxHeight: 600, // Restricts dialog height
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        right:
                            55), // Optional spacing between image and close icon
                    child: Image.asset(
                      'assets/cleansafi.png',
                      height: 70,
                      fit: BoxFit.contain,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop<bool>(false);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          color: AppTheme.kBackgroundColor,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.close,
                            size: 22,
                            color: AppTheme.kAccent22GreyColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: screenWidth * .5, // Use safe screen width
                child: Text(
                  "Sign in",
                  style: const TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.normal,
                    color: AppTheme.kBlackColor,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Helvetica Neue',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Email address:',
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.normal,
                      color: AppTheme.kBlackColor,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Helvetica Neue',
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 30,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: TextFormField(
                    controller: _emailController, // Add controller
                    style: const TextStyle(
                      fontFamily: 'Helvetica Neue',
                      color: AppTheme.kBlackColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: AppTheme.kSecondaryGreyColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: AppTheme.kSecondaryGreyColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: AppTheme.kSecondaryGreyColor,
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: AppTheme.kSecondaryGreyColor,
                          width: 0.5,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 30,
                      ),
                      fillColor: AppTheme.kBackgroundColor,
                      hintStyle: TextStyle(
                        fontFamily: 'Helvetica Neue',
                        color: AppTheme.kDullGreyColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'password:',
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.normal,
                      color: AppTheme.kBlackColor,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Helvetica Neue',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: TextFormField(
                    controller: _passwordController, // Add controller
                    obscureText: true, // Hide password
                    style: const TextStyle(
                      fontFamily: 'Helvetica Neue',
                      color: AppTheme.kBlackColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: AppTheme.kSecondaryGreyColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: AppTheme.kSecondaryGreyColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: AppTheme.kSecondaryGreyColor,
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: AppTheme.kSecondaryGreyColor,
                          width: 0.5,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 30,
                      ),
                      fillColor: AppTheme.kBackgroundColor,
                      hintStyle: TextStyle(
                        fontFamily: 'Helvetica Neue',
                        color: AppTheme.kDullGreyColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: MaterialButton(
                    color: AppTheme.pickerColor3,
                    minWidth: double.infinity,
                    height: 36,
                    elevation: 3,
                    onPressed: _signInWithEmailAndPassword, // Call sign-in method
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'Sign in',
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.normal,
                        color: AppTheme.kBackgroundColor,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Helvetica Neue',
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
