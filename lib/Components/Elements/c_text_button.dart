import 'package:flutter/material.dart';
import 'package:getactive/Style/colors.dart';

class CTextButton extends StatelessWidget {
  const CTextButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final Function onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.all(
          pinkText.withOpacity(0.3),
        ),
      ),
      onPressed: () => onPressed(),
      child: Text(
        text,
        style: TextStyle(
          color: pinkText,
          fontSize: 20,
        ),
      ),
    );
  }
}
