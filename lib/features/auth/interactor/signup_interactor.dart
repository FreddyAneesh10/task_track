import '../domain/entities/user_entity.dart';
import '../domain/entities/signup_request.dart';
import '../domain/repository/auth_repository.dart';

abstract class SignupInteractor {
  Future<UserEntity> execute(SignupRequest request);
}

class SignupInteractorImpl implements SignupInteractor {
  final AuthRepository _repository;

  SignupInteractorImpl(this._repository);

  @override
  Future<UserEntity> execute(SignupRequest request) async {
    // Business logic validation could go here
    return await _repository.signup(request);
  }
}
