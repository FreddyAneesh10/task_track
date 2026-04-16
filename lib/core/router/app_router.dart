import 'package:go_router/go_router.dart';
import 'package:task_track/features/auth/presentation/router/auth_router.dart';
import 'package:task_track/features/dashboard/presentation/router/dashboard_router.dart';
import 'package:task_track/features/splash/presentation/view/splash_view.dart';

class AppRouter {
  static const String splash = '/';

  static final config = GoRouter(
    initialLocation: DashboardRouter.dashboard,
    routes: [
      GoRoute(
        path: splash,
        builder: (context, state) => const SplashView(),
      ),
      ...AuthRouter.routes,
      ...DashboardRouter.routes,
    ],
  );
}
