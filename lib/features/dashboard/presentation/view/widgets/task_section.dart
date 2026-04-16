import 'package:flutter/material.dart';
import 'package:task_track/core/constants/app_colors.dart';
import 'package:task_track/features/dashboard/presentation/view/widgets/empty_task_state.dart';
import 'package:task_track/features/dashboard/presentation/view/widgets/task_action_button.dart';
import 'package:task_track/features/dashboard/presentation/view/widgets/task_filter_panel.dart';
import 'package:task_track/features/dashboard/presentation/view/widgets/task_pagination.dart';
import 'package:task_track/features/dashboard/presentation/view/widgets/task_table_header.dart';
import 'package:task_track/features/dashboard/presentation/view/widgets/task_tabs.dart';

class TaskSection extends StatefulWidget {
  final int selectedTabIndex;
  final Function(int) onTabChanged;

  const TaskSection({
    super.key,
    required this.selectedTabIndex,
    required this.onTabChanged,
  });

  @override
  State<TaskSection> createState() => _TaskSectionState();
}

class _TaskSectionState extends State<TaskSection> {
  bool _isFilterVisible = false;

  void _toggleFilters() {
    setState(() {
      _isFilterVisible = !_isFilterVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TaskTabs(
            selectedIndex: widget.selectedTabIndex,
            onTabChanged: widget.onTabChanged),
        const SizedBox(height: 32),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surface : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: isDark
                ? Border.all(
                    color: AppColors.fieldBorder.withValues(alpha: 0.5),
                  )
                : Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tasks',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(width: 24),
                    Row(
                      children: [
                        TaskActionButton(
                          text: 'Export To Excel',
                          isDark: isDark,
                          onPressed: () {},
                        ),
                        const SizedBox(width: 8),
                        TaskActionButton(
                          text: 'Filters',
                          icon: Icons.filter_alt_outlined,
                          isDark: isDark,
                          isActive: _isFilterVisible,
                          onPressed: _toggleFilters,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Animated Filter Panel
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: _isFilterVisible
                    ? Column(
                        children: [
                          const SizedBox(height: 24),
                          TaskFilterPanel(isDark: isDark),
                        ],
                      )
                    : const SizedBox.shrink(),
              ),

              const SizedBox(height: 24),
              // Horizontal Scrollable Table Headers
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    TaskTableHeader(title: 'Project Code', isDark: isDark),
                    TaskTableHeader(title: 'Project', isDark: isDark),
                    TaskTableHeader(title: 'Task Code', isDark: isDark),
                    TaskTableHeader(title: 'Title', isDark: isDark),
                    TaskTableHeader(title: 'Start Date', isDark: isDark),
                    TaskTableHeader(title: 'Status', isDark: isDark),
                    TaskTableHeader(title: 'Due Date', isDark: isDark),
                    TaskTableHeader(title: 'Priority', isDark: isDark),
                    TaskTableHeader(title: 'Assignee', isDark: isDark),
                  ],
                ),
              ),
              const Divider(height: 48),
              const SizedBox(
                height: 200,
                child: Center(child: EmptyTaskState()),
              ),
              const Divider(height: 32),
              const SizedBox(height: 8),
              // Pagination Row
              TaskPagination(
                currentPage: 1,
                totalPages: 1,
                isDark: isDark,
                onPrevious: () {},
                onNext: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
