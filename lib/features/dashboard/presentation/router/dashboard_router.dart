import 'package:go_router/go_router.dart';
import 'package:task_track/features/dashboard/presentation/view/screens/dashboard_view.dart';

class DashboardRouter {
  static const String dashboard = '/dashboard';

  static List<RouteBase> get routes => [
        GoRoute(
          path: dashboard,
          builder: (context, state) => const DashboardView(),
        ),
      ];
}
