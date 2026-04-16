import 'package:flutter/material.dart';
import 'package:task_track/features/dashboard/presentation/presenter/dashboard_state.dart';
import 'package:task_track/features/dashboard/presentation/view/widgets/summary_card.dart';

class DashboardStatsGrid extends StatelessWidget {
  final DashboardState state;

  const DashboardStatsGrid({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.22,
      children: [
        SummaryCard(
          title: 'Departments',
          value: state.stats.departments.toString(),
          icon: Icons.business_outlined,
        ),
        SummaryCard(
          title: 'Services',
          value: state.stats.services.toString(),
          icon: Icons.build_outlined,
        ),
        SummaryCard(
          title: 'Projects',
          value: state.stats.projects.toString(),
          icon: Icons.folder_open_rounded,
        ),
        SummaryCard(
          title: 'Clients',
          value: state.stats.clients.toString(),
          icon: Icons.people_outline_rounded,
        ),
      ],
    );
  }
}
