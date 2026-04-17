import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_track/features/user/domain/entities/user_search_filter.dart';
import 'package:task_track/features/user/interactor/user_interactor.dart';
import 'package:task_track/features/user/presentation/presenter/user_state.dart';

class UserPresenter extends StateNotifier<UserState> {
  final UserInteractor _interactor;

  UserPresenter(this._interactor) : super(const UserState()) {
    loadUsers();
  }

  Future<void> loadUsers() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final filter = UserSearchFilter(
        query: state.searchQuery,
        selectedStatus: state.selectedStatus,
        selectedRole: state.selectedRole,
        page: state.currentPage,
        itemsPerPage: state.itemsPerPage,
      );

      final response = await _interactor.fetchUsers(filter);
      
      state = state.copyWith(
        isLoading: false,
        users: response.items,
        totalResults: response.total,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  void searchUsers(String query) {
    state = state.copyWith(searchQuery: query, currentPage: 1, isLoading: true);
    loadUsers();
  }

  void setStatusFilter(String status) {
    state = state.copyWith(selectedStatus: status, currentPage: 1, isLoading: true);
    loadUsers();
  }

  void setRoleFilter(String role) {
    state = state.copyWith(selectedRole: role, currentPage: 1, isLoading: true);
    loadUsers();
  }

  void onNextPage() {
    if (state.currentPage * state.itemsPerPage < state.totalResults) {
      state = state.copyWith(currentPage: state.currentPage + 1, isLoading: true);
      loadUsers();
    }
  }

  void onPreviousPage() {
    if (state.currentPage > 1) {
      state = state.copyWith(currentPage: state.currentPage - 1, isLoading: true);
      loadUsers();
    }
  }
}
