import 'package:task_track/features/user/domain/entities/app_user.dart';

class UserState {
  final bool isLoading;
  final List<AppUser> users;
  final String searchQuery;
  final String selectedStatus;
  final String selectedRole;
  final int currentPage;
  final int itemsPerPage;
  final int totalResults;
  final String? errorMessage;

  const UserState({
    this.isLoading = false,
    this.users = const [],
    this.searchQuery = '',
    this.selectedStatus = 'All Status',
    this.selectedRole = 'All Roles',
    this.currentPage = 1,
    this.itemsPerPage = 5,
    this.totalResults = 0,
    this.errorMessage,
  });

  UserState copyWith({
    bool? isLoading,
    List<AppUser>? users,
    String? searchQuery,
    String? selectedStatus,
    String? selectedRole,
    int? currentPage,
    int? itemsPerPage,
    int? totalResults,
    String? errorMessage,
  }) {
    return UserState(
      isLoading: isLoading ?? this.isLoading,
      users: users ?? this.users,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedStatus: selectedStatus ?? this.selectedStatus,
      selectedRole: selectedRole ?? this.selectedRole,
      currentPage: currentPage ?? this.currentPage,
      itemsPerPage: itemsPerPage ?? this.itemsPerPage,
      totalResults: totalResults ?? this.totalResults,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
