import 'package:cleansafi/color_pallette.dart';
import 'package:cleansafi/date_field.dart';
import 'package:cleansafi/time_field.dart';
import 'package:flutter/material.dart';

class Recurrent extends StatelessWidget {
  const Recurrent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: false,
      tilePadding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      collapsedIconColor: AppTheme.kBackgroundColor,
      leading: const Icon(
        Icons.arrow_drop_down_outlined,
        size: 24,
        color: AppTheme.kBlackColor,
      ),
      trailing: const SizedBox.shrink(),
      title: Text(
        'Recurrent cleaning',
        style: TextStyle(
          fontSize: 14,
          fontStyle: FontStyle.normal,
          color: AppTheme.kBlackColor,
          fontWeight: FontWeight.w700,
          fontFamily: 'Helvetica Neue',
        ),
      ),
      children: [
        SizedBox(height: 5,),
        DateInputScreen(
          labelText: 'Select starting date',
        ),
        DateInputScreen(
          labelText: 'Select finishing date',
        ),
        TimeInputScreen(),
      ],
    );
  }
}
