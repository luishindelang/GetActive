import 'package:flutter/material.dart';
import 'package:getactive/Style/colors.dart';

class CTextBox extends StatelessWidget {
  const CTextBox({
    super.key,
    required this.controller,
    required this.onChange,
    required this.readOnly,
    required this.focus,
    this.lines = 1,
  });

  final TextEditingController controller;
  final Function(String) onChange;
  final bool readOnly;
  final FocusNode focus;
  final int lines;

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
      child: SingleChildScrollView(
        child: TextField(
          style: TextStyle(
            color: pinkText,
          ),
          focusNode: focus,
          readOnly: readOnly,
          keyboardType: TextInputType.multiline,
          minLines: lines,
          maxLines: lines,
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
      ),
    );
  }
}
