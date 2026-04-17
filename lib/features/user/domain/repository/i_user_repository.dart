import 'package:task_track/features/user/domain/entities/app_user.dart';
import 'package:task_track/features/user/domain/entities/user_search_filter.dart';
import 'package:task_track/features/user/domain/entities/paginated_response.dart';

abstract class IUserRepository {
  Future<PaginatedResponse<AppUser>> fetchUsers(UserSearchFilter filter);
  Future<void> createUser(AppUser user, String password);
}
