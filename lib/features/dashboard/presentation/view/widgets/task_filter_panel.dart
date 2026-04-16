import 'package:flutter/material.dart';
import 'package:task_track/core/constants/app_colors.dart';
import 'package:task_track/features/dashboard/presentation/view/widgets/task_filter_field.dart';

class TaskFilterPanel extends StatelessWidget {
  final bool isDark;

  const TaskFilterPanel({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0F172A) : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.filter_alt_outlined,
                size: 16,
                color: isDark ? AppColors.textSecondary : Colors.grey,
              ),
              const SizedBox(width: 8),
              Text(
                'Filter Options',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDark ? AppColors.textSecondary : Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
              TaskFilterField(
                label: 'Select the Filter',
                hint: 'Select a saved filter',
                isDark: isDark,
                icon: Icons.keyboard_arrow_down_rounded,
                width: 250,
              ),
              TaskFilterField(
                label: 'Search Title',
                hint: 'Search tasks...',
                isDark: isDark,
                prefixIcon: Icons.search_rounded,
                width: 200,
              ),
              TaskFilterField(
                label: 'Task Code',
                hint: 'Filter by code...',
                isDark: isDark,
                width: 180,
              ),
              TaskFilterField(
                label: 'Status',
                hint: 'All Statuses',
                isDark: isDark,
                icon: Icons.keyboard_arrow_down_rounded,
                width: 200,
              ),
              TaskFilterField(
                label: 'Priority',
                hint: 'All Priorities',
                isDark: isDark,
                icon: Icons.keyboard_arrow_down_rounded,
                width: 200,
              ),
              TaskFilterField(
                label: 'Project',
                hint: 'All Projects',
                isDark: isDark,
                icon: Icons.keyboard_arrow_down_rounded,
                width: 200,
              ),
              TaskFilterField(
                label: 'Assignee',
                hint: 'All Assignees',
                isDark: isDark,
                icon: Icons.keyboard_arrow_down_rounded,
                width: 200,
              ),
              TaskFilterField(
                label: 'Start Date Range',
                hint: 'Select date range',
                isDark: isDark,
                prefixIcon: Icons.calendar_today_outlined,
                width: 200,
              ),
              TaskFilterField(
                label: 'Due Date Range',
                hint: 'Select date range',
                isDark: isDark,
                prefixIcon: Icons.calendar_today_outlined,
                width: 200,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
