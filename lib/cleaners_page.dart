import 'package:another_flushbar/flushbar.dart';
import 'package:cleansafi/color_pallette.dart';
import 'package:cleansafi/users_orders_made.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CleanersPage extends StatefulWidget {
  final String? location;
  final String? house;
  final String? phone;
  final String? name;
  final String? bedrooms;
  final String? bathrooms;
  final int? totalAmount;

  const CleanersPage({
    super.key,
    this.bedrooms,
    this.bathrooms,
    this.location,
    this.house,
    this.phone,
    this.name,
    this.totalAmount,
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
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      debugPrint("Error: ${e.message}");
      return null;
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
        title: Row(
          children: [
            Image.asset(
              'assets/cleansafi.png',
              height: 90,
            ),
            const SizedBox(width: 35),
            const Text(
              "Our Cleaners",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('cleanersApply')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No cleaners found.'));
          }

          final cleaners = snapshot.data!.docs;

          return ListView.builder(
            itemCount: cleaners.length,
            itemBuilder: (context, index) {
              final cleaner = cleaners[index];
              final firstName = cleaner['first_name'] ?? 'N/A';
              final lastName = cleaner['last_name'] ?? 'N/A';
              final age = cleaner['age']?.toString() ?? 'Unknown';
              final cleanerEmail = cleaner['email_address'];

              return ListTile(
                leading: CircleAvatar(
                  radius: 40,
                  backgroundImage: cleaner['photo'] != null &&
                          cleaner['photo'].toString().isNotEmpty
                      ? NetworkImage(cleaner['photo'])
                      : const AssetImage('assets/sweepstar_two.png')
                          as ImageProvider,
                  backgroundColor: Colors.grey[200],
                ),
                title: Text(
                  '$firstName $lastName',
                  style: const TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.normal,
                    color: AppTheme.kBlackColor,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Helvetica Neue',
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Age: $age',
                      style: const TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.normal,
                        color: AppTheme.kBlackColor,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Helvetica Neue',
                      ),
                    ),
                    const SizedBox(height: 4),

                    // ⭐ ADDED: FutureBuilder to display average rating
                    FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('cleanerRating')
                          .doc(cleanerEmail)
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text('Loading rating...');
                        }

                        if (!snapshot.hasData || !snapshot.data!.exists) {
                          return const Text('No rating yet');
                        }

                        final data =
                            snapshot.data!.data() as Map<String, dynamic>;
                        final avgRating = data['average_rating'] ?? 0.0;
                        final totalReviews = data['total_reviews'] ?? 0;

                        return Text(
                          'Rating: ${avgRating.toStringAsFixed(1)} ⭐ ($totalReviews reviews)',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.amber,
                            fontFamily: 'Helvetica Neue',
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 10),
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
                        onPressed: () async {
                          final cleanerEmail = cleaner['email_address'];
                          final cleanerPhoto = cleaner['photo'];
                          final cleanerName = cleaner['first_name'];
                          final user = FirebaseAuth.instance.currentUser;

                          try {
                            await FirebaseFirestore.instance
                                .collection('indoorCleaning')
                                .add({
                              'location': widget.location,
                              'house': widget.house,
                              'phone': widget.phone,
                              'name': widget.name,
                              'number_of_bedrooms': widget.bedrooms,
                              'number_of_bathrooms': widget.bathrooms,
                              'cleaner_email': cleanerEmail,
                              'cleaner_photo': cleanerPhoto,
                              'cleaner_name': cleanerName,
                              'amount_payable': widget.totalAmount,
                              'user_id': user?.uid,
                              'createdAt': FieldValue.serverTimestamp(),
                            });

                            await Flushbar(
                              messageText: const Text(
                                "Cleaner selected successfully and booking sent!",
                                style: TextStyle(
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
                                  offset: Offset(0, 4.5),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(12),
                              margin: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                              flushbarPosition: FlushbarPosition.TOP,
                              duration: const Duration(seconds: 3),
                              animationDuration:
                                  const Duration(milliseconds: 400),
                              forwardAnimationCurve: Curves.easeOut,
                              reverseAnimationCurve: Curves.easeIn,
                              isDismissible: true,
                              padding: const EdgeInsets.all(16),
                            ).show(context);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UsersOrdersMade(),
                              ),
                            );
                          } catch (e) {
                            debugPrint("Error saving booking: $e");
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Failed to send booking. Try again.'),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          "Choose me",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
