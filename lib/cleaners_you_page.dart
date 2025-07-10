import 'package:cleansafi/cleaner_reviews.dart';
import 'package:cleansafi/cleaners_home_page.dart';
import 'package:cleansafi/color_pallette.dart';
import 'package:cleansafi/get_started.dart';
import 'package:cleansafi/profile_dialog.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

// Dummy HomePage placeholder (you should replace this with your actual home page)
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: const Center(child: Text("Welcome to the Home Page")),
    );
  }
}

class CleanersYouPage extends StatefulWidget {
  const CleanersYouPage({super.key});

  @override
  State<CleanersYouPage> createState() => _CleanersYouPageState();
}

class _CleanersYouPageState extends State<CleanersYouPage> {
  int currentIndex = 1; // Set to 1 to reflect "You" page as selected
  String? userEmail;
  String? cleanerEmail;

  @override
  void initState() {
    super.initState();
    final currentUser = FirebaseAuth.instance.currentUser;
    userEmail = currentUser?.email;
    cleanerEmail = currentUser?.email; // Assuming same for now
  }

  Future<void> signOutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const GetStartedPage()),
        );
      }
    } catch (e) {
      debugPrint("Error signing out: $e");
    }
  }

  String getEmailInitials(String email) {
    if (email.isEmpty || !email.contains('@')) return '';
    return email[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.kBackgroundColor,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: AppTheme.kBackgroundColor,
        elevation: 3,
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
                height: 36,
                elevation: 3,
                onPressed: signOutUser,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'Sign out',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.kBlackColor,
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
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              leading: CircleAvatar(
                backgroundColor: AppTheme.kPrimaryColorV2,
                child: Text(
                  getEmailInitials(userEmail ?? ''),
                  style: const TextStyle(
                    color: AppTheme.kBackgroundColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              subtitle: Text(
                userEmail ?? 'user@mail.com',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.kBlackColor,
                  fontFamily: 'Helvetica Neue',
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          ListTile(
            contentPadding: const EdgeInsets.only(left: 20),
            onTap: () {
              showDialog<void>(
                context: context,
                builder: (_) => Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: AppTheme.kBackgroundColor,
                  child: const ProfileDialog(),
                ),
              );
            },
            leading: SvgPicture.asset('assets/inactive_you_tab_icon.svg',
                height: 20, width: 20),
            title: const Text(
              'View Profile',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Graphik',
              ),
            ),
            subtitle: const Text(
              'This includes your name and email address',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppTheme.kSecondary2GreyColor,
                fontFamily: 'Helvetica Neue',
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 7),
          ListTile(
            contentPadding: const EdgeInsets.only(left: 20),
            onTap: () async {
              final emailLaunchUri =
                  Uri(scheme: 'mailto', path: 'murimikennedy69@gmail.com');
              if (await canLaunchUrl(emailLaunchUri)) {
                await launchUrl(emailLaunchUri);
              }
            },
            leading:
                SvgPicture.asset('assets/support.svg', height: 20, width: 20),
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
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppTheme.kSecondary2GreyColor,
                fontFamily: 'Helvetica Neue',
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 7),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: FutureBuilder<DocumentSnapshot>(
              future: cleanerEmail != null
                  ? FirebaseFirestore.instance
                      .collection('cleanerRating')
                      .doc(cleanerEmail)
                      .get()
                  : null,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text('Loading rating...');
                }
                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return const Text('No rating yet');
                }
                final data = snapshot.data!.data() as Map<String, dynamic>;
                final avgRating = (data['average_rating'] ?? 0.0).toDouble();
                final totalReviews = data['total_reviews'] ?? 0;

                return Text(
                  'You have a Rating of: ${avgRating.toStringAsFixed(1)} ⭐ ($totalReviews reviews)',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.kBlackColor,
                    fontFamily: 'Helvetica Neue',
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 7),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CleanerReviewsPage()),
              );
            },
            child: const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'See your reviews',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.kBlackColor,
                  fontFamily: 'Helvetica Neue',
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        backgroundColor: AppTheme.kBackgroundColor,
        selectedIconTheme: const IconThemeData(color: AppTheme.kBlackColor),
        onTap: (index) {
          if (index == currentIndex) return;

          setState(() {
            currentIndex = index;
          });

          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const CleanersHomePage()),
            );
          } else if (index == 1) {
            // Already on this page, no action needed
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: SvgPicture.asset(
                currentIndex == 0
                    ? 'assets/active_home_tab_icon.svg'
                    : 'assets/inactive_home_tab_icon.svg',
                height: 25,
                width: 25,
              ),
            ),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: SvgPicture.asset(
                currentIndex == 1
                    ? 'assets/active_you_tab_icon.svg'
                    : 'assets/inactive_you_tab_icon.svg',
                height: 25,
                width: 25,
              ),
            ),
            label: 'you',
          ),
        ],
      ),
    );
  }
}
