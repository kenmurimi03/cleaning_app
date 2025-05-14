import 'package:cleansafi/color_pallette.dart';
import 'package:cleansafi/get_started.dart';
import 'package:cleansafi/profile_dialog.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class YouPage extends StatefulWidget {
  const YouPage({
    super.key,
  });

  @override
  State<YouPage> createState() => _YouPageState();
}

class _YouPageState extends State<YouPage> {
  final currentIndexNotifier = ValueNotifier<int>(0);

  //sign out function
  Future<void> signOutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
      debugPrint("User signed out successfully");
    } catch (e) {
      debugPrint("Error signing out: $e");
    }
  }

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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 7),
            child: SizedBox(
              width: 120,
              child: MaterialButton(
                color: AppTheme.kBackgroundColor,
                minWidth: double.infinity,
                height: 36,
                elevation: 3,
                onPressed: () {
                  signOutUser();
                  // Navigate to get started page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GetStartedPage()),
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'Sign out',
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
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 15),
          SizedBox(
            height: 70,
            child: ListTile(
              minLeadingWidth: 11,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              visualDensity: VisualDensity.compact,
              leading: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: AppTheme.kPrimaryColorV2,
                    ),
                    child: Center(
                      child: Text(
                        getEmailInitials(userEmail!),
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppTheme.kBackgroundColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // title: Text(
              //   user?.user.name ?? FormFolderOwnerType.user.name,
              //   style: const TextStyle(
              //     color: AppTheme.kBlackColor,
              //     fontWeight: FontWeight.w600,
              //     fontFamily: 'Helvetica Neue',
              //     fontSize: 18,
              //   ),
              // ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
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
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          ListTile(
            dense: true,
            minLeadingWidth: 9.95,
            contentPadding: const EdgeInsets.only(left: 20),
            visualDensity: VisualDensity.compact,
            onTap: () {
              showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 2,
                    backgroundColor: AppTheme.kBackgroundColor,
                    child: ProfileDialog(),
                  );
                },
              );
            },
            leading: SizedBox(
              height: 20,
              width: 20,
              child: SvgPicture.asset(
                'assets/inactive_you_tab_icon.svg',
              ),
            ),
            title: const Text(
              'View Profile',
              style: TextStyle(
                fontFamily: 'Graphik',
                fontStyle: FontStyle.normal,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: const Text(
              'This includes your name and email address',
              style: TextStyle(
                fontFamily: 'Helvetica Neue',
                fontSize: 12,
                color: AppTheme.kSecondary2GreyColor,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          ListTile(
            dense: true,
            minLeadingWidth: 1.95,
            contentPadding: const EdgeInsets.only(left: 20),
            visualDensity: VisualDensity.compact,
            style: ListTileStyle.list,
            onTap: () async {
              final emailLaunchUri = Uri(
                scheme: 'mailto',
                path: 'murimikennedy69@gmail.com',
              );

              await launchUrl(emailLaunchUri);
            },
            leading: SizedBox(
              height: 20,
              width: 20,
              child: SvgPicture.asset(
                'assets/bug.svg',
              ),
            ),
            title: const Text(
              'Report a Bug',
              style: TextStyle(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
                fontFamily: 'Graphik',
                fontSize: 14,
              ),
            ),
            subtitle: const Text(
              'Report a bug while interacting with the system',
              style: TextStyle(
                fontFamily: 'Helvetica Neue',
                fontSize: 12,
                color: AppTheme.kSecondary2GreyColor,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          ListTile(
            dense: true,
            minLeadingWidth: 1.95,
            contentPadding: const EdgeInsets.only(left: 20),
            visualDensity: VisualDensity.compact,
            style: ListTileStyle.list,
            onTap: () async {
              final emailLaunchUri = Uri(
                scheme: 'mailto',
                path: 'murimikennedy69@gmail.com',
                // query: Misc.encodeQueryParameters(
                //   <String, String>{
                //     'subject': 'Requesting a new feature',
                //     'body': '...'
                //         '\n\nThank you. '
                //         '\n\nBest regards, '
                //         '\n[Your Name]',
                //   },
                // ),
              );

              await launchUrl(emailLaunchUri);
            },
            leading: SizedBox(
              height: 20,
              width: 20,
              child: SvgPicture.asset(
                'assets/support.svg',
              ),
            ),
            title: const Text(
              'Contact support',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Graphik',
              ),
            ),
            subtitle: const Text(
              'You can talk to us incase of any query or issue',
              style: TextStyle(
                fontFamily: 'Helvetica Neue',
                fontSize: 12,
                color: AppTheme.kSecondary2GreyColor,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
