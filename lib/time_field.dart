import 'package:cleansafi/color_pallette.dart';
import 'package:flutter/material.dart';

class TimeInputScreen extends StatefulWidget {
  const TimeInputScreen({
    super.key,
  });

  @override
  TimeInputScreenState createState() => TimeInputScreenState();
}

class TimeInputScreenState extends State<TimeInputScreen> {
  final TextEditingController _timeController = TextEditingController();

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        _timeController.text =
            picked.format(context); // Format time based on locale
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _timeController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: "select time",
        labelStyle: TextStyle(
          fontSize: 15,
          fontStyle: FontStyle.normal,
          color: AppTheme.kBlackColor,
          fontWeight: FontWeight.w500,
          fontFamily: 'Helvetica Neue',
        ),
        suffixIcon: IconButton(
          icon: Icon(Icons.access_time),
          onPressed: () => _selectTime(context),
        ),
        border: OutlineInputBorder(),
      ),
    );
  }
}
