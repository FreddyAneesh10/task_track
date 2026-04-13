import 'package:flutter/material.dart';
import 'package:task_track/core/constants/app_colors.dart';

class LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final glowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

    final path = Path();
    
    // Draw a stylized 'T' within the logo box
    // Top bar
    path.moveTo(size.width * 0.2, size.width * 0.3);
    path.lineTo(size.width * 0.8, size.width * 0.3);
    
    // Vertical bar
    path.moveTo(size.width * 0.5, size.width * 0.3);
    path.lineTo(size.width * 0.5, size.width * 0.8);

    // Nodes (circles at line ends)
    final nodePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = AppColors.accentBlue;

    // Draw lines with glow
    paint.color = AppColors.accentPurple;
    glowPaint.color = AppColors.accentPurple.withValues(alpha: 0.5);
    canvas.drawPath(path, glowPaint);
    canvas.drawPath(path, paint);

    // Draw circuit nodes
    canvas.drawCircle(Offset(size.width * 0.2, size.width * 0.3), 4, nodePaint);
    canvas.drawCircle(Offset(size.width * 0.8, size.width * 0.3), 4, nodePaint);
    canvas.drawCircle(Offset(size.width * 0.5, size.width * 0.8), 4, nodePaint);
    
    // Add some circuit junctions
    paint.color = AppColors.accentBlue;
    path.reset();
    path.moveTo(size.width * 0.35, size.width * 0.3);
    path.lineTo(size.width * 0.35, size.width * 0.5);
    path.lineTo(size.width * 0.5, size.width * 0.5);
    
    canvas.drawPath(path, paint);
    canvas.drawCircle(Offset(size.width * 0.35, size.width * 0.5), 3, nodePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
