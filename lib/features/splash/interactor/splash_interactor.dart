import 'package:task_track/features/splash/domain/usecase/initialize_app_usecase.dart';

abstract class SplashInteractor {
  Future<void> initialize();
}

class SplashInteractorImpl implements SplashInteractor {
  final InitializeAppUseCase _initializeAppUseCase;

  SplashInteractorImpl(this._initializeAppUseCase);

  @override
  Future<void> initialize() async {
    await _initializeAppUseCase.execute();
  }
}
