import 'package:cleansafi/color_pallette.dart';
import 'package:cleansafi/rate_cleaner_dialog.dart';
import 'package:cleansafi/services_offered.dart';
import 'package:cleansafi/you_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UsersOrdersMade extends StatefulWidget {
  const UsersOrdersMade({super.key, this.currentIndex});

  final int? currentIndex;

  @override
  State<UsersOrdersMade> createState() => _UsersOrdersMadeState();
}

class _UsersOrdersMadeState extends State<UsersOrdersMade> {
  final currentIndexNotifier = ValueNotifier<int>(0);
  final ValueNotifier<String> selectedBathroomNotifier =
      ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return ValueListenableBuilder<int>(
      valueListenable: currentIndexNotifier,
      builder: (context, currentIndex, _) {
        return Scaffold(
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
                  "Your orders",
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
                .collection('indoorCleaning')
                .where('user_id', isEqualTo: user?.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final bookings = snapshot.data?.docs ?? [];

              return bookings.isEmpty
                  ? const Center(
                      child: Text('No orders made yet'),
                    )
                  : ListView.builder(
                      itemCount: bookings.length,
                      itemBuilder: (context, index) {
                        final booking = bookings[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Your name: ${booking['name']}',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: PopupMenuButton<String>(
                                        onSelected: (newValue) {
                                          selectedBathroomNotifier.value =
                                              newValue;
                                          if (newValue == 'Rate cleaner') {
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  RateReviewDialog(
                                                cleanerEmail:
                                                    booking['cleaner_email'],
                                                cleanerName:
                                                    booking['cleaner_name'],
                                              ),
                                            );
                                          }
                                        },
                                        surfaceTintColor:
                                            AppTheme.kBackgroundColor,
                                        tooltip: 'Choose section',
                                        offset: const Offset(30, -5),
                                        splashRadius: 0.1,
                                        constraints: const BoxConstraints(
                                          minWidth: 81,
                                          minHeight: 50,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                        ),
                                        itemBuilder: (context) => const [
                                          PopupMenuItem(
                                            value: 'Chat to cleaner',
                                            height: 20,
                                            child: Text(
                                              'Chat to cleaner',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontStyle: FontStyle.normal,
                                                color: AppTheme.kBlackColor,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Helvetica Neue',
                                              ),
                                            ),
                                          ),
                                          PopupMenuItem(
                                            value: 'Rate cleaner',
                                            height: 20,
                                            child: Text(
                                              'Rate cleaner',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontStyle: FontStyle.normal,
                                                color: AppTheme.kBlackColor,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Helvetica Neue',
                                              ),
                                            ),
                                          ),
                                        ],
                                        elevation: 2,
                                        padding: EdgeInsets.zero,
                                        position: PopupMenuPosition.under,
                                        child: IgnorePointer(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: const [
                                                Text(
                                                  '',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontStyle: FontStyle.normal,
                                                    color: AppTheme.kBlackColor,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily:
                                                        'Helvetica Neue',
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.more_vert,
                                                  size: 23,
                                                  color: AppTheme.kBlackColor,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(thickness: 1, color: Colors.grey),
                                const SizedBox(height: 10),

                                // Location
                                Row(
                                  children: [
                                    const Icon(Icons.location_on,
                                        color: Colors.blueGrey),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        'Your Location: ${booking['location']}',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),

                                // Apartment/House
                                Row(
                                  children: [
                                    const Icon(Icons.home, color: Colors.brown),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        'Apartment/house: ${booking['house']}',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),

                                // Phone Number
                                Row(
                                  children: [
                                    const Icon(Icons.phone,
                                        color: Colors.green),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        'Phone: ${booking['phone']}',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),

                                Row(
                                  children: [
                                    const Icon(Icons.house,
                                        color: Colors.green),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        'House Details: ${booking['number_of_bedrooms']},${booking['number_of_bathrooms']}',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundImage: NetworkImage(
                                          booking['cleaner_photo']),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        ' You chose ${booking['cleaner_name']} as your cleaner',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 10),

                                Row(
                                  children: [
                                    const Icon(Icons.credit_card,
                                        color: Colors.blue),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        'Total amount: ${booking['amount_payable']}',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Click the menu button above to rate our cleaners after their services',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: AppTheme.kDarkErrorColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedIconTheme: const IconThemeData(color: AppTheme.kBlackColor),
            selectedItemColor: Colors.black,
            backgroundColor: AppTheme.kBackgroundColor,
            currentIndex: currentIndex,
            unselectedLabelStyle: const TextStyle(
              color: Colors.black,
              fontFamily: 'Helvetica Neue',
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
            selectedLabelStyle: const TextStyle(
              color: Colors.black,
              fontFamily: 'Helvetica Neue',
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
            onTap: (int index) {
              currentIndexNotifier.value = index;
              if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              } else if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const YouPage()),
                );
              }
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: SizedBox(
                    height: 25,
                    width: 25,
                    child: SvgPicture.asset(
                      currentIndex == 0
                          ? 'assets/active_home_tab_icon.svg'
                          : 'assets/inactive_home_tab_icon.svg',
                    ),
                  ),
                ),
                label: 'home',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: SizedBox(
                    height: 25,
                    width: 25,
                    child: SvgPicture.asset(
                      currentIndex == 1
                          ? 'assets/active_you_tab_icon.svg'
                          : 'assets/inactive_you_tab_icon.svg',
                    ),
                  ),
                ),
                label: 'you',
              ),
            ],
          ),
        );
      },
    );
  }
}
