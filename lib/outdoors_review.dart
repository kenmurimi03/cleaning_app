import 'package:cleansafi/cleaners_page.dart';
import 'package:cleansafi/color_pallette.dart';
import 'package:flutter/material.dart';

class UserrDetailsScreen extends StatelessWidget {
  final String? landSize;
  final String location;
  final String house;
  final String phoneNumber;
  final String customerName;

  const UserrDetailsScreen({
    super.key,
    this.landSize,
    required this.location,
    required this.house,
    required this.phoneNumber,
    required this.customerName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppTheme.kBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: AppTheme.kBlackColor,
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      // constraints: const BoxConstraints(maxHeight: 600, minWidth: 300),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Shrink dialog to content
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Booking Details",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.redAccent),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const Divider(thickness: 1, color: Colors.grey),
          const SizedBox(height: 10),

          // Location
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.blueGrey),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Your Location: $location",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
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
                  "Apartment/House: $house",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Phone Number
          Row(
            children: [
              const Icon(Icons.phone, color: Colors.green),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Phone: $phoneNumber",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Customer Name
          Row(
            children: [
              const Icon(Icons.person, color: Colors.blue),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Customer: $customerName",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          Row(
            children: [
              const Icon(Icons.cleaning_services, color: Colors.brown),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "land size: $landSize",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Confirm Button
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => CleanersPage()),
                );
              },
              child: const Text(
                "Confirm",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
