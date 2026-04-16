import 'package:task_track/features/dashboard/domain/entities/dashboard_stats.dart';
import 'package:task_track/features/dashboard/domain/entities/dashboard_task.dart';
import 'package:task_track/features/dashboard/domain/repositories/i_dashboard_repository.dart';

class DashboardInteractor {
  final IDashboardRepository _repository;

  DashboardInteractor(this._repository);

  Future<DashboardStats> fetchStats() {
    return _repository.getStats();
  }

  Future<List<DashboardTask>> fetchTasks() {
    return _repository.getTasks();
  }
}
