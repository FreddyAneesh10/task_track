import 'package:flutter/material.dart';

class TaskFilterField extends StatelessWidget {
  final String label;
  final String hint;
  final bool isDark;
  final IconData? icon;
  final IconData? prefixIcon;
  final double width;

  const TaskFilterField({
    super.key,
    required this.label,
    required this.hint,
    required this.isDark,
    this.icon,
    this.prefixIcon,
    this.width = 200,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: isDark ? Colors.black : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isDark ? Colors.white12 : Colors.grey.shade300,
              ),
            ),
            child: Row(
              children: [
                if (prefixIcon != null) ...[
                  Icon(prefixIcon,
                      size: 16, color: isDark ? Colors.grey : Colors.black54),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: Text(
                    hint,
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark ? Colors.grey.shade400 : Colors.black54,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (icon != null)
                  Icon(icon,
                      size: 16, color: isDark ? Colors.grey : Colors.black54),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
