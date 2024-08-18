import 'package:flutter/material.dart';

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
          Colors.pink[200]!.withOpacity(0.3),
        ),
      ),
      onPressed: () => onPressed(),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.pink[200]!,
          fontSize: 20,
        ),
      ),
    );
  }
}
