import 'package:another_flushbar/flushbar.dart';
import 'package:cleansafi/color_pallette.dart';
import 'package:cleansafi/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({
    super.key,
  });

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  Future<User?> registerWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user; // Successfully registered
    } on FirebaseAuthException catch (e) {
      print("Error: ${e.message}");
      return null;
    }
  }

  void _registerUser() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String firstName = _firstNameController.text.trim();
    String lastName = _lastNameController.text.trim();

    if (email.isEmpty ||
        password.isEmpty ||
        firstName.isEmpty ||
        lastName.isEmpty) {
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

    User? user = await registerWithEmailPassword(email, password);
    if (user != null) {
      // Registration successful
      if (mounted) {
         Flushbar(
            messageText: Text(
              "Registration successful",
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

      // Navigate to the sign-in screen
      if (mounted) {
        showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 2,
              backgroundColor: AppTheme.kBackgroundColor,
              child: SignInDialog(),
            );
          },
        );
      }
    } else {
      // Registration failed
      if (mounted) {
        Flushbar(
          messageText: Text(
            "Registration failed. Please try again!",
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
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.kBackgroundColor,
      appBar: AppBar(
        centerTitle: false,
        shadowColor: AppTheme.kSecondaryGreyColor,
        backgroundColor: AppTheme.kBackgroundColor,
        surfaceTintColor: AppTheme.kBackgroundColor,
        elevation: 3,
        leadingWidth: 20,
        automaticallyImplyLeading: false,
        title: Image.asset(
          'assets/cleansafi.png',
          height: 90,
        ),
      ),
      body: ListView(
        children: [
          Card(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 30,
                  color: AppTheme.pickerColor3,
                  child: const Padding(
                    padding: EdgeInsets.all(4),
                    child: Text(
                      'Join us',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.normal,
                        color: AppTheme.kBackgroundColor,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Helvetica Neue',
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 13,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '''First Name:''',
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.normal,
                        color: AppTheme.kBlackColor,
                        fontWeight: FontWeight.w700,
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
                      controller: _firstNameController,
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
                      'Last name:',
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.normal,
                        color: AppTheme.kBlackColor,
                        fontWeight: FontWeight.w700,
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
                      controller: _lastNameController,
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
                      'Email address:',
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.normal,
                        color: AppTheme.kBlackColor,
                        fontWeight: FontWeight.w700,
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
                      controller: _emailController,
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
                        fontWeight: FontWeight.w700,
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
                      controller: _passwordController,
                      obscureText: true,
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
                )
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: MaterialButton(
              color: AppTheme.pickerColor3,
              minWidth: double.infinity,
              height: 36,
              elevation: 3,
              onPressed: _registerUser,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'Save details and head to sign in',
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
        ],
      ),
    );
  }
}
