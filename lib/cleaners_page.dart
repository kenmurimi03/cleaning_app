import 'package:cleansafi/color_pallette.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CleanersPage extends StatefulWidget {
  const CleanersPage({
    super.key,
  });

  @override
  State<CleanersPage> createState() => _CleanersPageState();
}

class _CleanersPageState extends State<CleanersPage> {
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
      debugPrint("Error: ${e.message}");
      return null;
    }
  }

  // void _registerUser() async {
  //   String email = _emailController.text.trim();
  //   String password = _passwordController.text.trim();
  //   String firstName = _firstNameController.text.trim();
  //   String lastName = _lastNameController.text.trim();

  //   if (email.isEmpty ||
  //       password.isEmpty ||
  //       firstName.isEmpty ||
  //       lastName.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text("Please fill in all fields."),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //     return;
  //   }

  //   User? user = await registerWithEmailPassword(email, password);
  //   if (user != null) {
  //     // Registration successful
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text("Registration successful!"),
  //           backgroundColor: Colors.green,
  //         ),
  //       );
  //     }

  //     // Navigate to the sign-in screen
  //     if (mounted) {
  //       showDialog<void>(
  //                       context: context,
  //                       builder: (BuildContext context) {
  //                         return Dialog(
  //                           shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(10),
  //                           ),
  //                           elevation: 2,
  //                           backgroundColor: AppTheme.kBackgroundColor,
  //                           child: SignInDialog(),
  //                         );
  //                       },
  //                     );
  //     }
  //   } else {
  //     // Registration failed
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text("Registration failed. Please try again."),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //     }
  //   }
  // }

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
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Column(
                children: [
                  Image.asset(
                    'assets/sweepstar_one.png',
                    height: 210,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CleanersPage()),
                        );
                      },
                      child: const Text(
                        "Confirm",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(
              ),
              Column(
                children: [
                  Image.asset(
                    'assets/sweepstar_two.png',
                    height: 210,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CleanersPage()),
                        );
                      },
                      child: const Text(
                        "Confirm",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
