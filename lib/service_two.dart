import 'package:cleansafi/color_pallette.dart';
import 'package:cleansafi/indoors_review.dart';
import 'package:cleansafi/one_time.dart';
import 'package:cleansafi/recurrent.dart';
import 'package:flutter/material.dart';

class ServicestwoPage extends StatefulWidget {
  const ServicestwoPage({
    super.key,
  });

  @override
  State<ServicestwoPage> createState() => _ServicestwoPageState();
}

class _ServicestwoPageState extends State<ServicestwoPage> {
  final ValueNotifier<String> selectedBedroomNotifier =
      ValueNotifier<String>('Select Laundry size');

  final currentIndexNotifier = ValueNotifier<int>(0);
  final _locationController = TextEditingController();
  final _houseController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _customerNameController = TextEditingController();

  void _registerUser() async {
    String location = _locationController.text.trim();
    String house = _houseController.text.trim();
    String phoneNumber = _phoneNumberController.text.trim();
    String customerName = _customerNameController.text.trim();

    if (location.isEmpty ||
        house.isEmpty ||
        phoneNumber.isEmpty ||
        customerName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please fill in all fields."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    } else {
      if (mounted) {
        showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 2,
              backgroundColor: AppTheme.kBackgroundColor,
              child: UserDetailsScreen(
                location: location,
                house: house,
                phoneNumber: phoneNumber,
                customerName: customerName,
              ),
            );
          },
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _locationController.dispose();
    _houseController.dispose();
    _phoneNumberController.dispose();
    _customerNameController.dispose();
    super.dispose();
  }

  void filterForm() {}

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
      ),
      body: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          canvasColor: AppTheme.kBackgroundColor,
          appBarTheme: const AppBarTheme(
            color: AppTheme.kAppBarThemeColor,
          ),
          colorScheme: ColorScheme.fromSwatch(
            accentColor: AppTheme.kAppBarThemeColor,
          ),
        ),
        home: ListView(
          children: [
            Card(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 30,
                    color: AppTheme.pickerColor3,
                    child: const Padding(
                      padding: EdgeInsets.all(4),
                      child: Text(
                        'Location and contact information',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          color: AppTheme.kBackgroundColor,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Helvetica Neue',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '''Location of the place where you would like cleaned''',
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
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 25,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: TextFormField(
                        controller: _locationController,
                        style: const TextStyle(
                          fontFamily: 'Helvetica Neue',
                          color: AppTheme.kBlackColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: AppTheme.kSecondaryGreyColor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: AppTheme.kSecondaryGreyColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: AppTheme.kSecondaryGreyColor,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: AppTheme.kSecondaryGreyColor,
                              width: 0.5,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 30,
                          ),
                          fillColor: AppTheme.kBackgroundColor,
                          hintStyle: TextStyle(
                            fontFamily: 'Helvetica Neue',
                            color: AppTheme.kDullGreyColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Apartment name & house number',
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
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 25,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: TextFormField(
                        controller: _houseController,
                        style: const TextStyle(
                          fontFamily: 'Helvetica Neue',
                          color: AppTheme.kBlackColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: AppTheme.kSecondaryGreyColor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: AppTheme.kSecondaryGreyColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: AppTheme.kSecondaryGreyColor,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: AppTheme.kSecondaryGreyColor,
                              width: 0.5,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 30,
                          ),
                          fillColor: AppTheme.kBackgroundColor,
                          hintStyle: TextStyle(
                            fontFamily: 'Helvetica Neue',
                            color: AppTheme.kDullGreyColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Who should our cleaner contact?',
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
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 25,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: TextFormField(
                        controller: _phoneNumberController,
                        style: const TextStyle(
                          fontFamily: 'Helvetica Neue',
                          color: AppTheme.kBlackColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: AppTheme.kSecondaryGreyColor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: AppTheme.kSecondaryGreyColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: AppTheme.kSecondaryGreyColor,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: AppTheme.kSecondaryGreyColor,
                              width: 0.5,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 30,
                          ),
                          fillColor: AppTheme.kBackgroundColor,
                          hintStyle: TextStyle(
                            fontFamily: 'Helvetica Neue',
                            color: AppTheme.kDullGreyColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Name',
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
                  SizedBox(
                    height: 25,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: TextFormField(
                        controller: _customerNameController,
                        style: const TextStyle(
                          fontFamily: 'Helvetica Neue',
                          color: AppTheme.kBlackColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: AppTheme.kSecondaryGreyColor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: AppTheme.kSecondaryGreyColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: AppTheme.kSecondaryGreyColor,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: AppTheme.kSecondaryGreyColor,
                              width: 0.5,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 30,
                          ),
                          fillColor: AppTheme.kBackgroundColor,
                          hintStyle: TextStyle(
                            fontFamily: 'Helvetica Neue',
                            color: AppTheme.kDullGreyColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 30,
                    color: AppTheme.pickerColor3,
                    child: const Padding(
                      padding: EdgeInsets.all(4),
                      child: Text(
                        'Laundry Size',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          color: AppTheme.kBackgroundColor,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Helvetica Neue',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Number of items (approx)',
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
                      const SizedBox(
                        width: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: ValueListenableBuilder<String>(
                            valueListenable: selectedBedroomNotifier,
                            builder: (
                              BuildContext context,
                              String selectedValue,
                              Widget? child,
                            ) {
                              return PopupMenuButton<String>(
                                onSelected: (newValue) {
                                  selectedBedroomNotifier.value = newValue;
                                },
                                surfaceTintColor: AppTheme.kBackgroundColor,
                                tooltip: 'Choose section',
                                offset: const Offset(30, -5),
                                splashRadius: 0.1,
                                constraints: const BoxConstraints(
                                  minWidth: 81,
                                  minHeight: 50,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                itemBuilder: (context) => [
                                  const PopupMenuItem(
                                    value: '2 bags(20 items)',
                                    height: 20,
                                    child: Text(
                                      '2 bags(20 items)',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontStyle: FontStyle.normal,
                                        color: AppTheme.kBlackColor,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Helvetica Neue',
                                      ),
                                    ),
                                  ),
                                  const PopupMenuItem(
                                    value: '4 bags(40 items)',
                                    height: 20,
                                    child: Text(
                                      '4 bags(40 items)',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontStyle: FontStyle.normal,
                                        color: AppTheme.kBlackColor,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Helvetica Neue',
                                      ),
                                    ),
                                  ),
                                  const PopupMenuItem(
                                    value: '6 bags(60 items)',
                                    height: 20,
                                    child: Text(
                                      '6 bags(60 items)',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontStyle: FontStyle.normal,
                                        color: AppTheme.kBlackColor,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Helvetica Neue',
                                      ),
                                    ),
                                  ),
                                  const PopupMenuItem(
                                    value: '8 bags(80 items)',
                                    height: 20,
                                    child: Text(
                                      '8 bags(80 items)',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontStyle: FontStyle.normal,
                                        color: AppTheme.kBlackColor,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Helvetica Neue',
                                      ),
                                    ),
                                  ),
                                  const PopupMenuItem(
                                    value: '10 bags(100 items)',
                                    height: 20,
                                    child: Text(
                                      '10 bags(100 items)',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontStyle: FontStyle.normal,
                                        color: AppTheme.kBlackColor,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Helvetica Neue',
                                      ),
                                    ),
                                  ),
                                  const PopupMenuItem(
                                    value: 'above 10 bags',
                                    height: 20,
                                    child: Text(
                                      'above 10 bags',
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
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppTheme.kBackgroundColor,
                                      ),
                                      color: AppTheme.kBackgroundColor,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 8,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            selectedBedroomNotifier.value,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontStyle: FontStyle.normal,
                                              color: AppTheme.kBlackColor,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'Helvetica Neue',
                                            ),
                                          ),
                                          const Icon(
                                            Icons.keyboard_arrow_down,
                                            size: 18,
                                            color: AppTheme.kBlackColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 30,
                    color: AppTheme.pickerColor3,
                    child: const Padding(
                      padding: EdgeInsets.all(4),
                      child: Text(
                        'Cleaning Frequency',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          color: AppTheme.kBackgroundColor,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Helvetica Neue',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  OneTime(),
                  Recurrent(),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            Padding(
            padding: const EdgeInsets.all(8),
            child: MaterialButton(
              color: AppTheme.pickerColor3,
              minWidth: double.infinity,
              height: 36,
              elevation: 3,
              onPressed: _registerUser,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'Save details and review specifics',
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.normal,
                  color: AppTheme.kBackgroundColor,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Helvetica Neue',
                ),
              ),
            ),
          ),
          ],
        ),
      ),
    );
  }
}
