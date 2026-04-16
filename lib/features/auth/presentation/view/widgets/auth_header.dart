import 'package:flutter/material.dart';
import 'package:task_track/core/constants/app_colors.dart';
import 'package:task_track/features/auth/presentation/view/widgets/auth_logo.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isDark;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        const SizedBox(height: 60),
        const Center(child: AuthLogo()),
        Center(
          child: Text(
            title,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(
            subtitle,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isDark ? AppColors.textSecondary : AppColors.textSubheader,
            ),
          ),
        ),
      ],
    );
  }
}
