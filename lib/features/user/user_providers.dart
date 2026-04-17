import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_track/features/user/data/repository/user_repository_impl.dart';
import 'package:task_track/features/user/domain/repository/i_user_repository.dart';
import 'package:task_track/features/user/interactor/user_interactor.dart';
import 'package:task_track/features/user/presentation/presenter/user_presenter.dart';
import 'package:task_track/features/user/presentation/presenter/user_state.dart';
import 'package:task_track/features/user/presentation/presenter/add_user_presenter.dart';
import 'package:task_track/features/user/presentation/presenter/add_user_state.dart';

// Repository
final userRepositoryProvider = Provider<IUserRepository>((ref) {
  return UserRepositoryImpl();
});

// Interactor
final userInteractorProvider = Provider<UserInteractor>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return UserInteractor(repository);
});

// Presenter
final userPresenterProvider =
    StateNotifierProvider<UserPresenter, UserState>((ref) {
  final interactor = ref.watch(userInteractorProvider);
  return UserPresenter(interactor);
});

final addUserPresenterProvider =
    StateNotifierProvider.autoDispose<AddUserPresenter, AddUserState>((ref) {
  final interactor = ref.watch(userInteractorProvider);
  return AddUserPresenter(interactor);
});
