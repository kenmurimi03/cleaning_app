import 'package:cleansafi/color_pallette.dart';
import 'package:cleansafi/responsive_layout_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileDialog extends StatelessWidget {
  const ProfileDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      small: (_, __) => MobileProfileDialog(
        key: const Key('mobile_dialog'),
      ),
      large: (_, __) => SizedBox.shrink(
        key: const Key('web_dialog'),
      ),
    );
  }
}

class MobileProfileDialog extends StatefulWidget {
  const MobileProfileDialog({super.key});

  @override
  State<MobileProfileDialog> createState() => _MobileProfileDialogState();
}

class _MobileProfileDialogState extends State<MobileProfileDialog> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  //get user email function
  void getUserEmail() {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      debugPrint("User Email: ${user.email}");
    } else {
      debugPrint("No user is signed in.");
    }
  }

  // retrieve users' initial from email
  String getEmailInitials(String email) {
    if (email.isEmpty || !email.contains('@')) return '';

    List<String> parts = email.split('@');
    String username = parts[0]; // Before '@'

    String firstInitial = username.isNotEmpty ? username[0].toUpperCase() : '';

    return firstInitial;
  }

  String? userEmail = FirebaseAuth.instance.currentUser?.email;

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
              const SizedBox(height: 7),
              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Your email',
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
                  child: Text(
                    userEmail ?? 'user@mail.com',
                    style: const TextStyle(
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
                height: 15,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Username',
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
                  child: Text(
                    getEmailInitials(userEmail!),
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppTheme.kBlackColor,
                      fontSize: 14,
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
