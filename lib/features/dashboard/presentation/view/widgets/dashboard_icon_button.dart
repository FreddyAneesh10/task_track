import 'package:flutter/material.dart';
import 'package:task_track/core/constants/app_colors.dart';

class DashboardIconButton extends StatelessWidget {
  final IconData icon;
  final bool isDark;
  final VoidCallback? onPressed;
  final double size;
  final double iconSize;

  const DashboardIconButton({
    super.key,
    required this.icon,
    required this.isDark,
    this.onPressed,
    this.size = 40,
    this.iconSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: isDark ? Colors.transparent : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isDark ? AppColors.fieldBorder : Colors.grey.shade200,
        ),
      ),
      child: IconButton(
        icon: Icon(
          icon,
          size: iconSize,
          color: isDark ? Colors.white : Colors.black87,
        ),
        onPressed: onPressed,
        constraints: BoxConstraints(minWidth: size, minHeight: size),
        padding: EdgeInsets.zero,
      ),
    );
  }
}
