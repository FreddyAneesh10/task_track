import 'package:flutter/material.dart';
import 'package:task_track/core/constants/app_colors.dart';

class AuthFooter extends StatelessWidget {
  final String text;
  final String actionText;
  final VoidCallback onTap;
  final bool isDark;

  const AuthFooter({
    super.key,
    required this.text,
    required this.actionText,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isDark ? AppColors.textSecondary : AppColors.textSubheader,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            actionText,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.blue,
            ),
          ),
        ),
      ],
    );
  }
}
