import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_track/features/dashboard/interactor/dashboard_interactor.dart';
import 'package:task_track/features/dashboard/presentation/presenter/dashboard_state.dart';

class DashboardPresenter extends StateNotifier<DashboardState> {
  final DashboardInteractor _interactor;

  DashboardPresenter(this._interactor) : super(const DashboardState()) {
    init();
  }

  void init() async {
    state = state.copyWith(isLoading: true);
    try {
      final stats = await _interactor.fetchStats();
      final tasks = await _interactor.fetchTasks();
      state = state.copyWith(
        isLoading: false,
        stats: stats,
        tasks: tasks,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  void setTab(int index) {
    state = state.copyWith(selectedTabIndex: index);
  }

  void refresh() {
    init();
  }
}
