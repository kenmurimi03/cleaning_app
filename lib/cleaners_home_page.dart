import 'package:cleansafi/cleaners_you_page.dart';
import 'package:cleansafi/color_pallette.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CleanersHomePage extends StatefulWidget {
  const CleanersHomePage({super.key});

  @override
  State<CleanersHomePage> createState() => _CleanersHomePageState();
}

class _CleanersHomePageState extends State<CleanersHomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        shadowColor: AppTheme.kSecondaryGreyColor,
        backgroundColor: AppTheme.kBackgroundColor,
        surfaceTintColor: AppTheme.kBackgroundColor,
        elevation: 3,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset('assets/cleansafi.png', height: 90),
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
            .where('cleaner_email',
                isEqualTo: FirebaseAuth.instance.currentUser?.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final bookings = snapshot.data?.docs ?? [];

          return bookings.isEmpty
              ? const Center(child: Text('No orders received'))
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
                            Text(
                              'Client name: ${booking['name']}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const Divider(thickness: 1, color: Colors.grey),
                            const SizedBox(height: 10),
                            _infoRow(Icons.location_on, Colors.blueGrey,
                                'Location: ${booking['location']}'),
                            _infoRow(Icons.home, Colors.brown,
                                'Apartment/house: ${booking['house']}'),
                            _infoRow(Icons.phone, Colors.green,
                                'Phone: ${booking['phone']}'),
                            _infoRow(Icons.house, Colors.green,
                                'Bedrooms: ${booking['number_of_bedrooms']} • Bathrooms: ${booking['number_of_bathrooms']}'),
                            _infoRow(Icons.timer, Colors.blue,
                                'Arrive on 2nd June at 11am'),
                          ],
                        ),
                      ),
                    );
                  },
                );
        },
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

          if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const CleanersYouPage(),
              ),
            );
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

  Widget _infoRow(IconData icon, Color color, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
