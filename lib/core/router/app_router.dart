import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_track/features/auth/presentation/router/auth_router.dart';
import 'package:task_track/features/splash/presentation/view/splash_view.dart';
import 'package:task_track/features/dashboard/presentation/view/screens/navigation_shell_screen.dart';
import 'package:task_track/features/dashboard/presentation/view/screens/dashboard_view.dart';
import 'package:task_track/features/user/presentation/view/screens/user_dashboard_view.dart';
import 'package:task_track/features/common/presentation/view/screens/placeholder_screens.dart';

class AppRouter {
  static const String splash = '/';
  static const String dashboard = '/dashboard';
  static const String users = '/users';
  static const String departments = '/departments';
  static const String services = '/services';
  static const String clients = '/clients';
  static const String projects = '/projects';
  static const String reports = '/reports';

  static final config = GoRouter(
    initialLocation: dashboard,
    routes: [
      GoRoute(
        path: splash,
        builder: (context, state) => const SplashView(),
      ),
      ...AuthRouter.routes,
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return NavigationShellScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: dashboard,
                builder: (context, state) => const DashboardView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: users,
                builder: (context, state) => const UserDashboardView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: departments,
                builder: (context, state) => const PlaceholderScreen(
                  title: 'Departments',
                  icon: Icons.business_rounded,
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: services,
                builder: (context, state) => const PlaceholderScreen(
                  title: 'Services',
                  icon: Icons.build_outlined,
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: clients,
                builder: (context, state) => const PlaceholderScreen(
                  title: 'Clients',
                  icon: Icons.groups_outlined,
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: projects,
                builder: (context, state) => const PlaceholderScreen(
                  title: 'Projects',
                  icon: Icons.folder_open_rounded,
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: reports,
                builder: (context, state) => const PlaceholderScreen(
                  title: 'Reports',
                  icon: Icons.bar_chart_rounded,
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
