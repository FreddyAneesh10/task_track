import '../../domain/entities/user_entity.dart';
import '../../domain/entities/signup_request.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasource/auth_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final IAuthDataSource _dataSource;

  AuthRepositoryImpl(this._dataSource);

  @override
  Future<UserEntity> login(String username, String password) async {
    try {
      final data = await _dataSource.login(username, password);
      return UserEntity(
        id: data['id'],
        username: data['username'],
        role: data['role'],
      );
    } catch (e) {
      // Re-throw the exception so the interactor can handle it
      rethrow;
    }
  }

  @override
  Future<UserEntity> signup(SignupRequest request) async {
    // Simulated signup success
    await Future.delayed(const Duration(seconds: 1));
    return UserEntity(
      id: '999',
      username: request.username,
      role: 'user',
    );
  }
}
