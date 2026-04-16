import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_track/core/constants/app_colors.dart';
import 'package:task_track/core/theme/theme_provider.dart';

class AuthThemeToggle extends ConsumerWidget {
  final bool isDark;

  const AuthThemeToggle({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
      top: 8,
      right: 8,
      child: IconButton(
        icon: Icon(
          isDark ? Icons.wb_sunny_outlined : Icons.nightlight_outlined,
          color: isDark ? Colors.white : AppColors.textHeader,
        ),
        onPressed: () {
          ref.read(themeModeProvider.notifier).toggle(isDark);
        },
      ),
    );
  }
}
