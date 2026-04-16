import 'package:flutter/material.dart';

class AppLogoWidget extends StatelessWidget {
  final double width;
  final double height;
  final BoxFit fit;

  const AppLogoWidget({
    super.key,
    this.width = 150,
    this.height = 150,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/image (1).png',
      width: width,
      height: height,
      fit: fit,
    );
  }
}
