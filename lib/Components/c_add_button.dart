import 'package:flutter/material.dart';

class CAddButton extends StatelessWidget {
  const CAddButton({
    super.key,
    required this.onPressed,
  });

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.pink[100],
      shape: const CircleBorder(),
      child: IconButton(
        onPressed: () => onPressed(),
        icon: const Icon(
          Icons.add_rounded,
          size: 45,
          color: Colors.white,
        ),
      ),
    );
  }
}
