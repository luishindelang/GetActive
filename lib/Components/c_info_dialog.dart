import 'package:flutter/material.dart';

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
          cursorColor: Colors.pink[100],
          selectionColor: Colors.pink[100],
          selectionHandleColor: Colors.pink[100],
        ),
      ),
      child: SingleChildScrollView(
        child: TextField(
          style: TextStyle(
            color: Colors.pink[200]!,
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
              borderSide: BorderSide(width: 1, color: Colors.pink[100]!),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.pink[100]!),
            ),
          ),
          controller: controller,
        ),
      ),
    );
  }
}
