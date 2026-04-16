import 'package:task_track/features/dashboard/domain/entities/dashboard_stats.dart';
import 'package:task_track/features/dashboard/domain/entities/dashboard_task.dart';

abstract class IDashboardRepository {
  Future<DashboardStats> getStats();
  Future<List<DashboardTask>> getTasks();
}
