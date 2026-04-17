import 'package:flutter/material.dart';
import 'package:task_track/features/dashboard/presentation/view/widgets/task_filter_field.dart';

class UserFilterChips extends StatelessWidget {
  final String selectedStatus;
  final String selectedRole;
  final Function(String) onStatusChanged;
  final Function(String) onRoleChanged;

  const UserFilterChips({
    super.key,
    required this.selectedStatus,
    required this.selectedRole,
    required this.onStatusChanged,
    required this.onRoleChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: TaskFilterField(
              label: 'Status',
              hint: 'All Status',
              value: selectedStatus,
              isDark: isDark,
              width: double.infinity,
              options: const ['All Status', 'Active', 'Inactive'],
              onChanged: onStatusChanged,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TaskFilterField(
              label: 'Role',
              hint: 'All Roles',
              value: selectedRole,
              isDark: isDark,
              width: double.infinity,
              options: const ['All Roles', 'Admin', 'Manager', 'Associate'],
              onChanged: onRoleChanged,
            ),
          ),
        ],
      ),
    );
  }
}
