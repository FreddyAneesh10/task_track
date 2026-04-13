import 'package:go_router/go_router.dart';
import 'package:task_track/features/auth/presentation/router/auth_router.dart';
import 'package:task_track/features/splash/presentation/view/splash_view.dart';

class AppRouter {
  static const String splash = '/';

  static final config = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        builder: (context, state) => const SplashView(),
      ),
      ...AuthRouter.routes,
    ],
  );
}
