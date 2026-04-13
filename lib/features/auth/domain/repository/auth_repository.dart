import '../entities/user_entity.dart';
import '../entities/signup_request.dart';

abstract class AuthRepository {
  Future<UserEntity> login(String username, String password);
  Future<UserEntity> signup(SignupRequest request);
}
