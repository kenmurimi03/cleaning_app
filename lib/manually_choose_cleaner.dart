import 'package:cleansafi/cleaners_page.dart';
import 'package:cleansafi/color_pallette.dart';
import 'package:cleansafi/responsive_layout_builder.dart';
import 'package:flutter/material.dart';

class ManuallyChooseCleanerDialog extends StatelessWidget {
  final String location;
  final String house;
  final String phone;
  final String name;
  final String? bedrooms;
  final String? bathrooms;
  final int? totalAmount;
  const ManuallyChooseCleanerDialog({
    super.key,
    required this.location,
    required this.house,
    required this.phone,
    required this.name,
    this.bedrooms,
    this.bathrooms,
    this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      small: (_, __) => MobileManuallyChooseCleanerDialog(
        key: const Key('mobile_dialog'),
        location: location,
        house: house,
        phone: phone,
        name: name,
        bedrooms: bedrooms,
        bathrooms: bathrooms,
        totalAmount: totalAmount,
      ),
      large: (_, __) => const SizedBox.shrink(
        key: Key('web_dialog'),
      ),
    );
  }
}

class MobileManuallyChooseCleanerDialog extends StatelessWidget {
  final String location;
  final String house;
  final String phone;
  final String name;
  final String? bedrooms;
  final String? bathrooms;
  final int? totalAmount;
  const MobileManuallyChooseCleanerDialog({
    super.key,
    required this.location,
    required this.house,
    required this.phone,
    required this.name,
    this.bedrooms,
    this.bathrooms,
    this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: Center(
        child: Container(
          width: screenWidth * 0.8,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppTheme.kBackgroundColor,
          ),
          constraints: const BoxConstraints(
            maxHeight: 400,
            maxWidth: 500,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header row with logo and close button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/cleansafi.png',
                    height: 65,
                    fit: BoxFit.contain,
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pop<bool>(false),
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

              // Informative message row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Choose a cleaner of your choice from all the cleaners available",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Buttons row, centered horizontally
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ArchiveAction(
                    title: 'Proceed',
                    approves: true,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CleanersPage(
                            location: location,
                            house: house,
                            phone: phone,
                            name: name,
                            bedrooms: bedrooms,
                            bathrooms: bathrooms,
                            totalAmount: totalAmount,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 15),
                  ArchiveAction(
                    title: 'Cancel',
                    onPressed: () => Navigator.of(context).pop<bool>(false),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ArchiveAction extends StatelessWidget {
  const ArchiveAction({
    required this.title,
    this.approves = false,
    this.onPressed,
    super.key,
  });

  final String title;
  final bool approves;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      minWidth: 110,
      color: approves ? AppTheme.pickerColor3 : AppTheme.kBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 2,
      height: 35,
      child: Text(
        title,
        style: TextStyle(
          color: approves ? AppTheme.kBackgroundColor : AppTheme.kBlackColor,
          fontSize: 14,
          fontFamily: 'Helvetica Neue',
        ),
      ),
    );
  }
}
