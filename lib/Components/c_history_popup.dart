import 'package:flutter/material.dart';
import 'package:getactive/Components/c_info_dialog.dart';
import 'package:getactive/Components/c_text_button.dart';

class CHistoryPopup extends StatelessWidget {
  const CHistoryPopup({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Text(
                "Description",
                style: TextStyle(
                  color: Colors.pink[200]!,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 30),
              CInfoDialog(
                description: description,
              ),
            ],
          ),
        ),
        actions: [
          CTextButton(
            onPressed: () => Navigator.pop(context),
            text: "Ok",
          ),
        ]);
  }
}
