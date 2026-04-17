import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_track/features/user/user_providers.dart';
import 'package:task_track/features/user/presentation/view/widgets/user_dashboard_header.dart';
import 'package:task_track/features/user/presentation/view/widgets/user_search_bar.dart';
import 'package:task_track/features/dashboard/presentation/view/widgets/dashboard_top_nav.dart';
import 'package:task_track/features/user/presentation/view/widgets/user_filter_chips.dart';
import 'package:task_track/features/user/presentation/view/widgets/user_pagination_widget.dart';
import 'package:task_track/features/user/presentation/view/widgets/user_list_sliver.dart';

class UserDashboardView extends ConsumerWidget {
  const UserDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(userPresenterProvider);
    final presenter = ref.read(userPresenterProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : Colors.grey.shade50,
      body: SafeArea(
        child: Column(
          children: [
            const DashboardTopNav(),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: UserDashboardHeader(),
                  ),
                  SliverToBoxAdapter(
                    child: UserSearchBar(
                      onSearch: presenter.searchUsers,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: UserFilterChips(
                      selectedStatus: state.selectedStatus,
                      selectedRole: state.selectedRole,
                      onStatusChanged: presenter.setStatusFilter,
                      onRoleChanged: presenter.setRoleFilter,
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 8),
                  ),
                  UserListSliver(state: state),
                  SliverToBoxAdapter(
                    child: UserPaginationWidget(
                      currentPage: state.currentPage,
                      itemsPerPage: state.itemsPerPage,
                      totalResults: state.totalResults,
                      onPrevious: presenter.onPreviousPage,
                      onNext: presenter.onNextPage,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
