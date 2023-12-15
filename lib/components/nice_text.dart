import 'package:flutter/material.dart';

class NiceText extends StatelessWidget {
  final String text;
  //  final Color colorName = Colors.red;
  final Color? colorName;
  const NiceText({
    super.key,
    required this.text,
    this.colorName,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: colorName ?? Colors.red,
        fontSize: 25,
      ),
    );
  }
}
