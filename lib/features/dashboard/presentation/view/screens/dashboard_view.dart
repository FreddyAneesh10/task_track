import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_track/features/dashboard/dashboard_providers.dart';
import 'package:task_track/features/dashboard/presentation/view/widgets/dashboard_header.dart';
import 'package:task_track/features/dashboard/presentation/view/widgets/dashboard_stats_grid.dart';
import 'package:task_track/features/dashboard/presentation/view/widgets/dashboard_top_nav.dart';
import 'package:task_track/features/dashboard/presentation/view/widgets/task_section.dart';

class DashboardView extends ConsumerWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardPresenterProvider);
    final presenter = ref.read(dashboardPresenterProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.grey.shade50,
      body: SafeArea(
        child: Column(
          children: [
            const DashboardTopNav(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  // Logic to refresh dashboard data could go here
                },
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 24,
                  ),
                  children: [
                    const DashboardHeader(),
                    const SizedBox(height: 24),
                    DashboardStatsGrid(state: state),
                    const SizedBox(height: 32),
                    TaskSection(
                      selectedTabIndex: state.selectedTabIndex,
                      onTabChanged: presenter.setTab,
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
