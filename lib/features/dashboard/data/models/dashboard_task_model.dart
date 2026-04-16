import 'package:task_track/features/dashboard/domain/entities/dashboard_task.dart';

class DashboardTaskModel extends DashboardTask {
  const DashboardTaskModel({
    required super.projectCode,
    required super.projectName,
    required super.taskCode,
    required super.title,
    required super.startDate,
    required super.status,
    super.dueDate,
    required super.priority,
    required super.assignee,
  });

  factory DashboardTaskModel.fromJson(Map<String, dynamic> json) {
    return DashboardTaskModel(
      projectCode: json['project_code'],
      projectName: json['project_name'],
      taskCode: json['task_code'],
      title: json['title'],
      startDate: DateTime.parse(json['start_date']),
      status: TaskStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => TaskStatus.todo,
      ),
      dueDate: json['due_date'] != null ? DateTime.parse(json['due_date']) : null,
      priority: TaskPriority.values.firstWhere(
        (e) => e.toString().split('.').last == json['priority'],
        orElse: () => TaskPriority.medium,
      ),
      assignee: json['assignee'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'project_code': projectCode,
      'project_name': projectName,
      'task_code': taskCode,
      'title': title,
      'start_date': startDate.toIso8601String(),
      'status': status.toString().split('.').last,
      'due_date': dueDate?.toIso8601String(),
      'priority': priority.toString().split('.').last,
      'assignee': assignee,
    };
  }
}
