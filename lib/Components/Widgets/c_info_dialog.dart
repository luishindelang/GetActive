import 'package:flutter/material.dart';
import 'package:getactive/Style/colors.dart';

class CInfoDialog extends StatelessWidget {
  const CInfoDialog({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: description);
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
          focusNode: FocusNode(),
          readOnly: true,
          keyboardType: TextInputType.multiline,
          minLines: 1,
          maxLines: 20,
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
        ),
      ),
    );
  }
}
