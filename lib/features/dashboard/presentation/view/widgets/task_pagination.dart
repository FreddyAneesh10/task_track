import 'package:flutter/material.dart';
import 'package:task_track/core/constants/app_colors.dart';

class TaskPagination extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final bool isDark;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  const TaskPagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.isDark,
    this.onPrevious,
    this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Page $currentPage of $totalPages',
            style: TextStyle(
              fontSize: 13,
              color: isDark ? AppColors.textSecondary : Colors.grey.shade600,
            ),
          ),
          const SizedBox(width: 24),
          Row(
            children: [
              _buildPaginationButton(
                context,
                'Previous',
                isDark,
                onPressed: onPrevious,
              ),
              const SizedBox(width: 12),
              Text(
                'Page $currentPage of $totalPages',
                style: TextStyle(
                  fontSize: 13,
                  color:
                      isDark ? AppColors.textSecondary : Colors.grey.shade600,
                ),
              ),
              const SizedBox(width: 12),
              _buildPaginationButton(
                context,
                'Next',
                isDark,
                onPressed: onNext,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaginationButton(
    BuildContext context,
    String text,
    bool isDark, {
    VoidCallback? onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E293B) : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isDark ? Colors.white10 : Colors.grey.shade300,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
          ),
        ),
      ),
    );
  }
}
