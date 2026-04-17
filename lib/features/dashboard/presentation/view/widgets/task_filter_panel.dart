import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_track/core/constants/app_colors.dart';
import 'package:task_track/features/dashboard/dashboard_providers.dart';
import 'package:task_track/features/dashboard/presentation/view/widgets/task_filter_field.dart';

class TaskFilterPanel extends ConsumerWidget {
  final bool isDark;

  const TaskFilterPanel({super.key, required this.isDark});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardPresenterProvider);
    final notifier = ref.read(dashboardPresenterProvider.notifier);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
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
                value: state.statusFilter,
                isDark: isDark,
                icon: Icons.keyboard_arrow_down_rounded,
                width: 200,
                options: const [
                  'All Statuses',
                  'Open',
                  'Pending',
                  'In Progress',
                ],
                onChanged: (value) => notifier.setStatusFilter(value),
              ),
              TaskFilterField(
                label: 'Priority',
                hint: 'All Priorities',
                value: state.priorityFilter,
                isDark: isDark,
                icon: Icons.keyboard_arrow_down_rounded,
                width: 200,
                options: const [
                  'All Priorities',
                  'Low',
                  'Medium',
                  'High',
                  'Critical',
                ],
                onChanged: (value) => notifier.setPriorityFilter(value),
              ),
              TaskFilterField(
                label: 'Project',
                hint: 'All Projects',
                value: state.projectFilter,
                isDark: isDark,
                icon: Icons.keyboard_arrow_down_rounded,
                width: 200,
                options: const [
                  'All Projects',
                  'Alpha Project',
                  'Beta Phase',
                  'Internal Task',
                  'Customer Portal',
                ],
                showSearch: true,
                searchPlaceholder: 'Search project...',
                onChanged: (value) => notifier.setProjectFilter(value),
              ),
              TaskFilterField(
                label: 'Assignee',
                hint: 'All Assignees',
                value: state.assigneeFilter,
                isDark: isDark,
                icon: Icons.keyboard_arrow_down_rounded,
                width: 200,
                options: const ['All Assignees', 'Freddy Aneesh.'],
                showSearch: true,
                searchPlaceholder: 'Search assignee...',
                onChanged: (value) => notifier.setAssigneeFilter(value),
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
