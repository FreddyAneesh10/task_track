import 'package:task_track/features/dashboard/domain/entities/dashboard_stats.dart';

class DashboardStatsModel extends DashboardStats {
  const DashboardStatsModel({
    required super.departments,
    required super.services,
    required super.projects,
    required super.clients,
  });

  factory DashboardStatsModel.fromJson(Map<String, dynamic> json) {
    return DashboardStatsModel(
      departments: json['departments'] ?? 0,
      services: json['services'] ?? 0,
      projects: json['projects'] ?? 0,
      clients: json['clients'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'departments': departments,
      'services': services,
      'projects': projects,
      'clients': clients,
    };
  }
}
