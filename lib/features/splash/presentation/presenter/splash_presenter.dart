import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_track/features/splash/interactor/splash_interactor.dart';
import 'package:task_track/features/splash/presentation/router/splash_router.dart';

class SplashPresenter extends StateNotifier<AsyncValue<void>> {
  final SplashInteractor _interactor;
  final SplashRouter _router;

  SplashPresenter(this._interactor, this._router) : super(const AsyncValue.data(null));

  Future<void> init(BuildContext context) async {
    state = const AsyncValue.loading();
    try {
      await _interactor.initialize();
      if (context.mounted) {
        _router.navigateToSignIn(context);
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
