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
    if (state.selectedTabIndex == index) return;
    state = state.copyWith(selectedTabIndex: index);
  }

  void setProjectFilter(String value) {
    if (state.projectFilter == value) return;
    state = state.copyWith(projectFilter: value);
  }

  void setAssigneeFilter(String value) {
    if (state.assigneeFilter == value) return;
    state = state.copyWith(assigneeFilter: value);
  }

  void setStatusFilter(String value) {
    if (state.statusFilter == value) return;
    state = state.copyWith(statusFilter: value);
  }

  void setPriorityFilter(String value) {
    if (state.priorityFilter == value) return;
    state = state.copyWith(priorityFilter: value);
  }

  void refresh() {
    init();
  }
}
