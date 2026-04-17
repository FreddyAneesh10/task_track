class UserSearchFilter {
  final String query;
  final String selectedStatus;
  final String selectedRole;
  final int page;
  final int itemsPerPage;

  const UserSearchFilter({
    this.query = '',
    this.selectedStatus = 'All Status',
    this.selectedRole = 'All Roles',
    this.page = 1,
    this.itemsPerPage = 10,
  });

  UserSearchFilter copyWith({
    String? query,
    String? selectedStatus,
    String? selectedRole,
    int? page,
    int? itemsPerPage,
  }) {
    return UserSearchFilter(
      query: query ?? this.query,
      selectedStatus: selectedStatus ?? this.selectedStatus,
      selectedRole: selectedRole ?? this.selectedRole,
      page: page ?? this.page,
      itemsPerPage: itemsPerPage ?? this.itemsPerPage,
    );
  }
}
