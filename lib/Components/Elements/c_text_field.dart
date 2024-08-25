import 'package:flutter/material.dart';
import 'package:getactive/Style/colors.dart';

class CTextField extends StatelessWidget {
  const CTextField({
    super.key,
    required this.controller,
    required this.onChange,
  });

  final TextEditingController controller;
  final Function(String) onChange;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: pinkForground,
          selectionColor: pinkForground,
          selectionHandleColor: pinkForground,
        ),
      ),
      child: TextField(
        style: TextStyle(
          color: pinkText,
        ),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.only(bottom: 0),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 1, color: pinkForground),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 1, color: pinkForground),
          ),
        ),
        controller: controller,
        onChanged: (value) => onChange(value),
      ),
    );
  }
}
