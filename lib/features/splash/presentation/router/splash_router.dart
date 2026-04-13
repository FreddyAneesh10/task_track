import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_track/features/auth/presentation/router/auth_router.dart';

abstract class SplashRouter {
  void navigateToSignIn(BuildContext context);
}

class SplashRouterImpl implements SplashRouter {
  @override
  void navigateToSignIn(BuildContext context) {
    // Navigate using go_router for consistency across the app
    context.go(AuthRouter.login);
  }
}
