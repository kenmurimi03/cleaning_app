import 'package:cleansafi/cleaners_apply.dart';
import 'package:cleansafi/color_pallette.dart';
import 'package:cleansafi/responsive_layout_builder.dart';
import 'package:flutter/material.dart';

class CleanerDialog extends StatelessWidget {
  const CleanerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      small: (_, __) => MobileCleanerDialog(
        key: const Key('mobile_dialog'),
      ),
      large: (_, __) => SizedBox.shrink(
        key: const Key('web_dialog'),
      ),
    );
  }
}

class MobileCleanerDialog extends StatelessWidget {
  const MobileCleanerDialog({super.key});

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
              SizedBox(
                width: screenWidth * .5, // Use safe screen width
                child: Text(
                  "What you need to be a cleaner",
                  style: const TextStyle(
                    color: AppTheme.kBlackColor,
                    fontSize: 14,
                    fontFamily: 'Graphik',
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.check, size: 20, color: AppTheme.kBlackColor),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Have worked as a domestic cleaner/gardener for 2 years or more.",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.check, size: 20, color: AppTheme.kBlackColor),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "A smartphone with WhatsApp",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.check, size: 20, color: AppTheme.kBlackColor),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "To speak English at a basic level.",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.check, size: 20, color: AppTheme.kBlackColor),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "A clean criminal record.",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ArchiveAction(
                      title: 'Apply',
                      approves: true,
                      onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CleanersApply()),
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
