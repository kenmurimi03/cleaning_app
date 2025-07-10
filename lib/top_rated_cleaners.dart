import 'package:another_flushbar/flushbar.dart';
import 'package:cleansafi/color_pallette.dart';
import 'package:cleansafi/users_orders_made.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TopRatedCleanersDialog extends StatefulWidget {
  final String? location;
  final String? house;
  final String? phone;
  final String? name;
  final String? bedrooms;
  final String? bathrooms;
  final int? totalAmount;

  const TopRatedCleanersDialog({
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
  State<TopRatedCleanersDialog> createState() => _TopRatedCleanersDialogState();
}

class _TopRatedCleanersDialogState extends State<TopRatedCleanersDialog> {
  Future<List<Map<String, dynamic>>> _fetchTopRatedCleaners() async {
    final cleanersSnapshot =
        await FirebaseFirestore.instance.collection('cleanersApply').get();
    final ratingsSnapshot =
        await FirebaseFirestore.instance.collection('cleanerRating').get();

    final ratingsMap = <String, Map<String, dynamic>>{};
    for (var doc in ratingsSnapshot.docs) {
      ratingsMap[doc.id] = doc.data();
    }

    List<Map<String, dynamic>> cleanersWithRatings = [];

    for (var cleanerDoc in cleanersSnapshot.docs) {
      final data = cleanerDoc.data();
      final email = data['email_address'] as String? ?? '';
      final ratingData = ratingsMap[email];
      final avgRating =
          ratingData != null ? (ratingData['average_rating'] ?? 0.0) : 0.0;
      final totalReviews =
          ratingData != null ? (ratingData['total_reviews'] ?? 0) : 0;

      final combined = Map<String, dynamic>.from(data);
      combined['average_rating'] = avgRating;
      combined['total_reviews'] = totalReviews;

      cleanersWithRatings.add(combined);
    }

    cleanersWithRatings.sort((a, b) {
      final r1 = a['average_rating'] as double;
      final r2 = b['average_rating'] as double;
      return r2.compareTo(r1);
    });

    return cleanersWithRatings.take(3).toList();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: Center(
        child: Container(
          width: screenWidth * 0.9,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppTheme.kBackgroundColor,
          ),
          constraints: const BoxConstraints(
            maxHeight: 550,
            maxWidth: 500,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/cleansafi.png',
                    height: 65,
                    fit: BoxFit.contain,
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
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
                ],
              ),

              const SizedBox(height: 20),

              // Title
              const Text(
                "Top 3 Cleaners Recommended for You",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Helvetica Neue',
                ),
              ),

              const SizedBox(height: 20),

              // Cleaners List
              FutureBuilder<List<Map<String, dynamic>>>(
                future: _fetchTopRatedCleaners(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No cleaners found.'));
                  }

                  final cleaners = snapshot.data!;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: cleaners.length,
                      itemBuilder: (context, index) {
                        final cleaner = cleaners[index];
                        final fullName =
                            "${cleaner['first_name'] ?? ''} ${cleaner['last_name'] ?? ''}";
                        final age = cleaner['age']?.toString() ?? 'Unknown';
                        final cleanerEmail = cleaner['email_address'] ?? '';
                        final avgRating = cleaner['average_rating'] ?? 0.0;
                        final totalReviews = cleaner['total_reviews'] ?? 0;
                        final photoUrl = cleaner['photo'];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 32,
                                backgroundImage: photoUrl != null &&
                                        photoUrl.toString().isNotEmpty
                                    ? NetworkImage(photoUrl)
                                    : const AssetImage(
                                            'assets/sweepstar_two.png')
                                        as ImageProvider,
                                backgroundColor: Colors.grey[300],
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      fullName,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Helvetica Neue',
                                      ),
                                    ),
                                    Text(
                                      'Age: $age',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontFamily: 'Helvetica Neue',
                                      ),
                                    ),
                                    Text(
                                      'Rating: ${avgRating.toStringAsFixed(1)} ⭐ ($totalReviews reviews)',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.amber,
                                        fontFamily: 'Helvetica Neue',
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    SizedBox(
                                      height: 35,
                                      width: 110,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppTheme.pickerColor3,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          elevation: 2,
                                        ),
                                        onPressed: () async {
                                          final cleanerPhoto = photoUrl;
                                          final cleanerName =
                                              cleaner['first_name'];
                                          final user =
                                              FirebaseAuth.instance.currentUser;

                                          try {
                                            await FirebaseFirestore.instance
                                                .collection('indoorCleaning')
                                                .add({
                                              'location': widget.location,
                                              'house': widget.house,
                                              'phone': widget.phone,
                                              'name': widget.name,
                                              'number_of_bedrooms':
                                                  widget.bedrooms,
                                              'number_of_bathrooms':
                                                  widget.bathrooms,
                                              'cleaner_email': cleanerEmail,
                                              'cleaner_photo': cleanerPhoto,
                                              'cleaner_name': cleanerName,
                                              'amount_payable':
                                                  widget.totalAmount,
                                              'user_id': user?.uid,
                                              'createdAt':
                                                  FieldValue.serverTimestamp(),
                                            });

                                            await Flushbar(
                                              messageText: const Text(
                                                "Cleaner selected successfully and booking sent!",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: AppTheme
                                                      .kSuccessMessageColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Helvetica Neue',
                                                ),
                                              ),
                                              backgroundColor:
                                                  AppTheme.kSuccessColor,
                                              boxShadows: const [
                                                BoxShadow(
                                                  color: Colors.black54,
                                                  blurRadius: 4,
                                                  offset: Offset(0, 4.5),
                                                ),
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              margin: const EdgeInsets.fromLTRB(
                                                  16, 20, 16, 0),
                                              flushbarPosition:
                                                  FlushbarPosition.TOP,
                                              duration:
                                                  const Duration(seconds: 3),
                                              animationDuration: const Duration(
                                                  milliseconds: 400),
                                              isDismissible: true,
                                              padding: const EdgeInsets.all(16),
                                            ).show(context);

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    UsersOrdersMade(),
                                              ),
                                            );
                                          } catch (e) {
                                            debugPrint(
                                                "Error saving booking: $e");
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Failed to send booking. Try again.'),
                                              ),
                                            );
                                          }
                                        },
                                        child: const Text(
                                          "Choose me",
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
