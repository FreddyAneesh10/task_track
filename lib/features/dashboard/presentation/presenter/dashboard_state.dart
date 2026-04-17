import 'package:task_track/features/dashboard/domain/entities/dashboard_stats.dart';
import 'package:task_track/features/dashboard/domain/entities/dashboard_task.dart';

class DashboardState {
  final bool isLoading;
  final DashboardStats stats;
  final List<DashboardTask> tasks;
  final String? errorMessage;
  final int selectedTabIndex; // 0: Active, 1: Other
  final String projectFilter;
  final String statusFilter;
  final String priorityFilter;
  final String assigneeFilter;

  const DashboardState({
    this.isLoading = false,
    this.stats = const DashboardStats.empty(),
    this.tasks = const [],
    this.errorMessage,
    this.selectedTabIndex = 0,
    this.projectFilter = 'All Projects',
    this.statusFilter = 'All Statuses',
    this.priorityFilter = 'All Priorities',
    this.assigneeFilter = 'All Assignees',
  });

  DashboardState copyWith({
    bool? isLoading,
    DashboardStats? stats,
    List<DashboardTask>? tasks,
    String? errorMessage,
    int? selectedTabIndex,
    String? projectFilter,
    String? statusFilter,
    String? priorityFilter,
    String? assigneeFilter,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      stats: stats ?? this.stats,
      tasks: tasks ?? this.tasks,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      projectFilter: projectFilter ?? this.projectFilter,
      statusFilter: statusFilter ?? this.statusFilter,
      priorityFilter: priorityFilter ?? this.priorityFilter,
      assigneeFilter: assigneeFilter ?? this.assigneeFilter,
    );
  }
}
