import 'package:flutter/material.dart';
import 'package:getactive/Style/colors.dart';

class CTimePicker extends StatelessWidget {
  const CTimePicker({
    super.key,
    required this.initialTime,
  });

  final TimeOfDay initialTime;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData().copyWith(
        colorScheme: ColorScheme.light(
          primary: pinkForground,
          onSurface: pinkText,
        ),
        dialogBackgroundColor: boxBackground,
      ),
      child: TimePickerDialog(initialTime: initialTime),
    );
  }
}
