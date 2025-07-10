import 'package:cleansafi/color_pallette.dart';
import 'package:cleansafi/manually_choose_cleaner.dart';
import 'package:cleansafi/sync_cleaner.dart';
import 'package:flutter/material.dart';

class UserDetailsScreen extends StatelessWidget {
  final String? selectedBedroom;
  final String? selectedBathroom;
  final String? laundrySize;
  final int? totalAmount;

  final String location;
  final String house;
  final String phoneNumber;
  final String customerName;

  const UserDetailsScreen({
    super.key,
    this.selectedBedroom,
    this.selectedBathroom,
    this.totalAmount,
    this.laundrySize,
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
              const Icon(Icons.house, color: Colors.green),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "House details: $selectedBedroom, $selectedBathroom",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          Row(
            children: [
              const Icon(Icons.credit_card, color: Colors.blue),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Amount payable: $totalAmount",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Confirm Button
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  minimumSize: const Size.fromHeight(50), // ensure full-width
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) =>  SyncCleanerDialog(
                      location: location,
                      house: house,
                      phone: phoneNumber,
                      name: customerName,
                      bedrooms: selectedBedroom,
                      bathrooms: selectedBathroom,
                      totalAmount: totalAmount,
                    ),
                  );
                },
                child: const Text(
                  "Sync cleaner",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16), // space between the buttons
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => ManuallyChooseCleanerDialog(
                      location: location,
                      house: house,
                      phone: phoneNumber,
                      name: customerName,
                      bedrooms: selectedBedroom,
                      bathrooms: selectedBathroom,
                      totalAmount: totalAmount,
                    ),
                  );
                },
                child: const Text(
                  "Choose cleaner",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
