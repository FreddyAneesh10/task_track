import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_track/core/constants/app_colors.dart';

class DashboardBottomNav extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const DashboardBottomNav({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BottomNavigationBar(
      currentIndex: navigationShell.currentIndex,
      onTap: (index) => navigationShell.goBranch(index),
      backgroundColor: isDark ? const Color(0xFF0F172A) : Colors.white,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: isDark ? Colors.white38 : Colors.grey,
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 10,
      unselectedFontSize: 10,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard_rounded),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_alt_outlined),
          label: 'Users',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business_rounded),
          label: 'Depts',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.build_outlined),
          label: 'Services',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.groups_outlined),
          label: 'Clients',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.folder_open_rounded),
          label: 'Projects',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart_rounded),
          label: 'Reports',
        ),
      ],
    );
  }
}
