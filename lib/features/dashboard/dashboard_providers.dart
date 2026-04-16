import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_track/features/dashboard/data/repository/dashboard_repository_impl.dart';
import 'package:task_track/features/dashboard/domain/repositories/i_dashboard_repository.dart';
import 'package:task_track/features/dashboard/interactor/dashboard_interactor.dart';
import 'package:task_track/features/dashboard/presentation/presenter/dashboard_presenter.dart';
import 'package:task_track/features/dashboard/presentation/presenter/dashboard_state.dart';

// Repository
final dashboardRepositoryProvider = Provider<IDashboardRepository>((ref) {
  return DashboardRepositoryImpl();
});

// Interactor
final dashboardInteractorProvider = Provider<DashboardInteractor>((ref) {
  final repository = ref.watch(dashboardRepositoryProvider);
  return DashboardInteractor(repository);
});

// Presenter (StateNotifierProvider)
final dashboardPresenterProvider =
    StateNotifierProvider<DashboardPresenter, DashboardState>((ref) {
  final interactor = ref.watch(dashboardInteractorProvider);
  return DashboardPresenter(interactor);
});
