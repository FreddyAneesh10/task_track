import 'package:flutter/material.dart';

class AuthLogo extends StatelessWidget {
  final double fontSize;
  final double letterSpacing;

  const AuthLogo({
    super.key,
    this.fontSize = 24,
    this.letterSpacing = 4,
    // Note: parameters from previous versions kept for compatibility or ignored
    double? iconSize,
    double? spacing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/image (1).png',
          width: 150,
          height: 150,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
