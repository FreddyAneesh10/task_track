import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_track/features/splash/domain/usecase/initialize_app_usecase.dart';
import 'package:task_track/features/splash/interactor/splash_interactor.dart';
import 'package:task_track/features/splash/presentation/presenter/splash_presenter.dart';
import 'package:task_track/features/splash/presentation/router/splash_router.dart';

final initializeAppUseCaseProvider = Provider<InitializeAppUseCase>((ref) {
  return InitializeAppUseCase();
});

final splashInteractorProvider = Provider<SplashInteractor>((ref) {
  final useCase = ref.watch(initializeAppUseCaseProvider);
  return SplashInteractorImpl(useCase);
});

final splashRouterProvider = Provider<SplashRouter>((ref) {
  return SplashRouterImpl();
});

final splashPresenterProvider = StateNotifierProvider<SplashPresenter, AsyncValue<void>>((ref) {
  final interactor = ref.watch(splashInteractorProvider);
  final router = ref.watch(splashRouterProvider);
  return SplashPresenter(interactor, router);
});
