import 'package:flutter/material.dart';
import 'package:getactive/Style/colors.dart';

class CDatePicker extends StatelessWidget {
  const CDatePicker({
    super.key,
    required this.initialDate,
  });

  final DateTime initialDate;

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
      child: DatePickerDialog(
        initialDate: initialDate,
        firstDate: initialDate.subtract(const Duration(days: 365 * 2)),
        lastDate: initialDate.add(const Duration(days: 365 * 5)),
      ),
    );
  }
}
