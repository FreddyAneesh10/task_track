import 'package:flutter/material.dart';
import 'package:task_track/core/constants/app_colors.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;
  final bool showBottomCurve;

  const AuthBackground({
    super.key,
    required this.child,
    this.showBottomCurve = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 0.8,
          colors: [
            AppColors.backgroundDeepBlue,
            AppColors.backgroundDark,
          ],
          stops: [0.0, 1.0],
        ),
      ),
      child: Stack(
        children: [
          // We can keep the architectural curves as subtle overlays if desired, 
          // but here we prioritize the Splash Screen's Gradient Theme.
          if (showBottomCurve)
            CustomPaint(
              size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
              painter: _AuthCurvePainter(),
            ),
          child,
        ],
      ),
    );
  }
}

class _AuthCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Subtle overlay curve for depth
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
        colors: [
          AppColors.primary.withValues(alpha: 0.05),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();
    path.moveTo(size.width, size.height * 0.6);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.8,
      0,
      size.height,
    );
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
