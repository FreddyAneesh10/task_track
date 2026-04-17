import 'package:flutter/material.dart';
import 'package:task_track/features/user/presentation/presenter/user_state.dart';
import 'package:task_track/features/user/presentation/view/widgets/user_empty_state.dart';
import 'package:task_track/features/user/presentation/view/widgets/user_list_item.dart';
import 'package:task_track/features/user/presentation/view/widgets/user_loading_widget.dart';

class UserListView extends StatelessWidget {
  final UserState state;

  const UserListView({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    if (state.isLoading && state.users.isEmpty) {
      return const UserLoadingWidget();
    }

    if (state.users.isEmpty) {
      return const UserEmptyState();
    }

    return ListView.builder(
      itemCount: state.users.length,
      padding: const EdgeInsets.only(top: 8, bottom: 24),
      itemBuilder: (context, index) {
        return UserListItem(user: state.users[index]);
      },
    );
  }
}
