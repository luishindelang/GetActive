import 'package:flutter/material.dart';
import 'package:getactive/Style/colors.dart';

class CAddButton extends StatelessWidget {
  const CAddButton({
    super.key,
    required this.onPressed,
  });

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: pinkForground,
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
