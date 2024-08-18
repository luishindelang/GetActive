import 'package:flutter/material.dart';

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
          cursorColor: Colors.pink[100],
          selectionColor: Colors.pink[100],
          selectionHandleColor: Colors.pink[100],
        ),
      ),
      child: TextField(
        style: TextStyle(
          color: Colors.pink[200]!,
        ),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.only(bottom: 0),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.pink[100]!),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.pink[100]!),
          ),
        ),
        controller: controller,
        onChanged: (value) => onChange(value),
      ),
    );
  }
}
