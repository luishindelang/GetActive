import 'package:flutter/material.dart';
import 'package:getactive/Components/Elements/c_text_button.dart';
import 'package:getactive/Style/colors.dart';

class CConfirmDelete extends StatelessWidget {
  const CConfirmDelete({
    super.key,
    required this.onConfirm,
  });

  final Function onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: boxBackground,
      content: Text(
        "Delete Item?",
        style: TextStyle(
          color: pinkText,
          fontSize: 22,
        ),
      ),
      actions: [
        CTextButton(
          onPressed: () => Navigator.pop(context),
          text: "Cancel",
        ),
        CTextButton(
          onPressed: () {
            onConfirm();
            Navigator.pop(context);
            Navigator.pop(context);
          },
          text: "Confirm",
        ),
      ],
    );
  }
}
