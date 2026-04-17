import 'package:flutter/material.dart';
import 'package:task_track/features/user/presentation/presenter/user_state.dart';
import 'package:task_track/features/user/presentation/view/widgets/user_empty_state.dart';
import 'package:task_track/features/user/presentation/view/widgets/user_list_item.dart';
import 'package:task_track/features/user/presentation/view/widgets/user_loading_widget.dart';

class UserListSliver extends StatelessWidget {
  final UserState state;

  const UserListSliver({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    if (state.isLoading && state.users.isEmpty) {
      return const SliverFillRemaining(
        child: UserLoadingWidget(),
      );
    }

    if (state.users.isEmpty) {
      return const SliverFillRemaining(
        child: UserEmptyState(),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => UserListItem(user: state.users[index]),
        childCount: state.users.length,
      ),
    );
  }
}
