import 'package:cleansafi/color_pallette.dart';
import 'package:flutter/material.dart';

class DateInputScreen extends StatefulWidget {
  const DateInputScreen({
    super.key,
    required this.labelText,

    });
  final String labelText;

  @override
  DateInputScreenState createState() => DateInputScreenState();
}

class DateInputScreenState extends State<DateInputScreen> {
  final TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        _dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _dateController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: TextStyle(
          fontSize: 15,
          fontStyle: FontStyle.normal,
          color: AppTheme.kBlackColor,
          fontWeight: FontWeight.w500,
          fontFamily: 'Helvetica Neue',
        ),
        suffixIcon: IconButton(
          icon: Icon(Icons.calendar_today),
          onPressed: () => _selectDate(context),
        ),
        border: OutlineInputBorder(),
      ),
    );
  }
}
