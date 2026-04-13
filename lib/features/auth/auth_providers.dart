import 'package:flutter_riverpod/flutter_riverpod.dart';

import './data/datasource/auth_datasource.dart';
import './data/datasource/auth_local_datasource.dart';
import './data/repository/auth_repository_impl.dart';
import './domain/repository/auth_repository.dart';
import 'interactor/login_interactor.dart';
import 'interactor/signup_interactor.dart';
import './presentation/presenter/login_presenter.dart';
import './presentation/presenter/signup_presenter.dart';

// DataSource
final authLocalDataSourceProvider = Provider<IAuthDataSource>((ref) {
  return AuthLocalDataSource();
});

// Repository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dataSource = ref.watch(authLocalDataSourceProvider);
  return AuthRepositoryImpl(dataSource);
});

// Interactors (VIPER)
final loginInteractorProvider = Provider<LoginInteractor>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LoginInteractorImpl(repository);
});

final signupInteractorProvider = Provider<SignupInteractor>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return SignupInteractorImpl(repository);
});

// Presenters (StateNotifierProviders)
final loginPresenterProvider =
    StateNotifierProvider.autoDispose<LoginPresenter, LoginState>((ref) {
  final interactor = ref.watch(loginInteractorProvider);
  return LoginPresenter(interactor);
});

final signupPresenterProvider =
    StateNotifierProvider.autoDispose<SignupPresenter, SignupState>((ref) {
  final interactor = ref.watch(signupInteractorProvider);
  return SignupPresenter(interactor);
});
