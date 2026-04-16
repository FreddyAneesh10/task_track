import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:task_track/features/dashboard/presentation/router/dashboard_router.dart';
import '../../presenter/login_presenter.dart'; // For BaseAuthState

mixin AuthViewHandler {
  void listenToAuthState<T extends BaseAuthState>(
    BuildContext context,
    WidgetRef ref,
    ProviderListenable<T> provider,
  ) {
    ref.listen<T>(provider, (previous, next) {
      if (next.user != null && previous?.user == null) {
        context.go(DashboardRouter.dashboard);
      }

      if (next.error != null && next.error != previous?.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error!),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });
  }
}
