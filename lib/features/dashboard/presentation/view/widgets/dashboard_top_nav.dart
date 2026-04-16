import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_track/core/constants/app_colors.dart';
import 'package:task_track/core/theme/theme_provider.dart';
import 'package:task_track/features/dashboard/presentation/view/widgets/dashboard_icon_button.dart';

class DashboardTopNav extends ConsumerWidget {
  const DashboardTopNav({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      color: isDark ? Colors.black : Colors.white,
      child: Row(
        children: [
          Flexible(
            child: Text(
              'TaskTrack',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ),
          const Spacer(),
          DashboardIconButton(
            icon: Icons.notifications_none_rounded,
            isDark: isDark,
            onPressed: () {},
          ),
          const SizedBox(width: 8),
          DashboardIconButton(
            icon: isDark ? Icons.wb_sunny_outlined : Icons.dark_mode,
            isDark: isDark,
            onPressed: () =>
                ref.read(themeModeProvider.notifier).toggle(isDark),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.logoBoxBackground,
            child: const Text(
              'F',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
