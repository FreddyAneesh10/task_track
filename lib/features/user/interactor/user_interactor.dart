import 'package:task_track/features/user/domain/entities/app_user.dart';
import 'package:task_track/features/user/domain/entities/user_search_filter.dart';
import 'package:task_track/features/user/domain/entities/paginated_response.dart';
import 'package:task_track/features/user/domain/repository/i_user_repository.dart';

class UserInteractor {
  final IUserRepository _repository;

  UserInteractor(this._repository);

  Future<PaginatedResponse<AppUser>> fetchUsers(UserSearchFilter filter) {
    return _repository.fetchUsers(filter);
  }

  Future<void> registerNewUser({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String role,
    required String status,
    required String password,
  }) async {
    final mappedRole = _mapRole(role);
    final mappedStatus = _mapStatus(status);

    final user = AppUser(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      username: username,
      firstName: firstName,
      lastName: lastName,
      email: email,
      role: mappedRole,
      status: mappedStatus,
    );

    return _repository.createUser(user, password);
  }

  UserRole _mapRole(String role) {
    switch (role.toLowerCase()) {
      case 'admin':
        return UserRole.admin;
      case 'manager':
        return UserRole.manager;
      case 'associate':
      default:
        return UserRole.associate;
    }
  }

  UserStatus _mapStatus(String status) {
    return status.toLowerCase() == 'active' ? UserStatus.active : UserStatus.inactive;
  }

  Future<void> createUser(AppUser user, String password) {
    return _repository.createUser(user, password);
  }
}
