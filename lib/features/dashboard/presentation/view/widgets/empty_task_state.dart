import 'package:flutter/material.dart';
import 'package:task_track/core/constants/app_colors.dart';

class EmptyTaskState extends StatelessWidget {
  const EmptyTaskState({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.search,
          size: 64,
          color: isDark ? AppColors.textTertiary : Colors.grey.shade300,
        ),
        const SizedBox(height: 16),
        Text(
          'No tasks found',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Try adjusting your filters to see more results',
          style: TextStyle(
            fontSize: 14,
            color: isDark ? AppColors.textSecondary : Colors.grey,
          ),
        ),
      ],
    );
  }
}
