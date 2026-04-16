import 'package:flutter/material.dart';
import 'package:task_track/core/constants/app_colors.dart';

class TaskActionButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final bool isDark;
  final VoidCallback? onPressed;
  final bool isActive;

  const TaskActionButton({
    super.key,
    required this.text,
    this.icon,
    required this.isDark,
    this.onPressed,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.primary
              : (isDark ? Colors.black : Colors.white),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isActive
                ? AppColors.primary
                : (isDark ? AppColors.fieldBorder : Colors.grey.shade300),
          ),
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 18,
                color: isActive
                    ? Colors.white
                    : (isDark ? Colors.white : Colors.black87),
              ),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isActive
                    ? Colors.white
                    : (isDark ? Colors.white : Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
