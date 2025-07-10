// indoor_cleaning_form_state.dart
import 'package:flutter/material.dart';

final TextEditingController locationController = TextEditingController();
final TextEditingController houseController = TextEditingController();
final TextEditingController phoneNumberController = TextEditingController();
final TextEditingController customerNameController = TextEditingController();

final ValueNotifier<int> selectedBedroomNotifier = ValueNotifier(0);
final ValueNotifier<int> selectedBathroomNotifier = ValueNotifier(0);
