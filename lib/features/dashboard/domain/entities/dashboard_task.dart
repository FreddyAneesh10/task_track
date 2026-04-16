enum TaskStatus {
  todo,
  inProgress,
  done,
  cancelled
}

enum TaskPriority {
  low,
  medium,
  high,
  urgent
}

class DashboardTask {
  final String projectCode;
  final String projectName;
  final String taskCode;
  final String title;
  final DateTime startDate;
  final TaskStatus status;
  final DateTime? dueDate;
  final TaskPriority priority;
  final String assignee;

  const DashboardTask({
    required this.projectCode,
    required this.projectName,
    required this.taskCode,
    required this.title,
    required this.startDate,
    required this.status,
    this.dueDate,
    required this.priority,
    required this.assignee,
  });
}
