import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_track/features/dashboard/presentation/view/widgets/dashboard_bottom_nav.dart';

class NavigationShellScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const NavigationShellScreen({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: DashboardBottomNav(navigationShell: navigationShell),
    );
  }
}
