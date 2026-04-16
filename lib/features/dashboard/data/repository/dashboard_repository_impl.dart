import 'package:task_track/features/dashboard/domain/entities/dashboard_stats.dart';
import 'package:task_track/features/dashboard/domain/entities/dashboard_task.dart';
import 'package:task_track/features/dashboard/domain/repositories/i_dashboard_repository.dart';

class DashboardRepositoryImpl implements IDashboardRepository {
  @override
  Future<DashboardStats> getStats() async {
    // Simulating API delay
    await Future.delayed(const Duration(milliseconds: 500));
    return const DashboardStats(
      departments: 0,
      services: 0,
      projects: 0,
      clients: 0,
    );
  }

  @override
  Future<List<DashboardTask>> getTasks() async {
    // Simulating API delay
    await Future.delayed(const Duration(milliseconds: 800));
    // Returning empty list as shown in the screenshot
    return [];
  }
}
