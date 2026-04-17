import 'package:task_track/features/user/domain/entities/app_user.dart';
import 'package:task_track/features/user/domain/entities/user_search_filter.dart';
import 'package:task_track/features/user/domain/entities/paginated_response.dart';
import 'package:task_track/features/user/domain/repository/i_user_repository.dart';

class UserRepositoryImpl implements IUserRepository {
  final List<AppUser> _mockUsers = [
    const AppUser(
      id: '1',
      username: 'Freddyy',
      firstName: 'Freddy',
      lastName: 'Aneesh',
      email: 'freddyaneeshh@gmail.com',
      role: UserRole.associate,
      status: UserStatus.active,
    ),
    const AppUser(
      id: '2',
      username: 'SarahS',
      firstName: 'Sarah',
      lastName: 'Smith',
      email: 'sarah.smith@example.com',
      role: UserRole.manager,
      status: UserStatus.active,
    ),
    const AppUser(
      id: '3',
      username: 'JohnD',
      firstName: 'John',
      lastName: 'Doe',
      email: 'john.doe@example.com',
      role: UserRole.admin,
      status: UserStatus.inactive,
    ),
    const AppUser(
      id: '4',
      username: 'MichaelB',
      firstName: 'Michael',
      lastName: 'Brown',
      email: 'michael.b@example.com',
      role: UserRole.associate,
      status: UserStatus.active,
    ),
    const AppUser(
      id: '5',
      username: 'EmilyW',
      firstName: 'Emily',
      lastName: 'White',
      email: 'johndoe@example.com',
      role: UserRole.manager,
      status: UserStatus.inactive,
    ),
    // ... add more if needed for testing pagination
  ];

  @override
  Future<PaginatedResponse<AppUser>> fetchUsers(UserSearchFilter filter) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    // 1. Filter by Search Query
    var filtered = _mockUsers.where((user) {
      final query = filter.query.toLowerCase();
      if (query.isEmpty) return true;
      return user.fullName.toLowerCase().contains(query) ||
          user.username.toLowerCase().contains(query) ||
          user.email.toLowerCase().contains(query);
    }).toList();

    // 2. Filter by Status
    if (filter.selectedStatus != 'All Status') {
      filtered = filtered.where((user) {
        final statusStr = user.status == UserStatus.active ? 'Active' : 'Inactive';
        return statusStr == filter.selectedStatus;
      }).toList();
    }

    // 3. Filter by Role
    if (filter.selectedRole != 'All Roles') {
      filtered = filtered.where((user) {
        final roleStr = user.role.name[0].toUpperCase() + user.role.name.substring(1);
        return roleStr == filter.selectedRole;
      }).toList();
    }

    final total = filtered.length;

    // 4. Pagination
    final startIndex = (filter.page - 1) * filter.itemsPerPage;
    final paginated = filtered.skip(startIndex).take(filter.itemsPerPage).toList();

    return PaginatedResponse(
      items: paginated,
      total: total,
    );
  }

  @override
  Future<void> createUser(AppUser user, String password) async {
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 800));
    _mockUsers.add(user);
  }
}
