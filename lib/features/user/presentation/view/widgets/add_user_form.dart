import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_track/core/helpers/auth_helper.dart';
import 'package:task_track/features/auth/presentation/view/widgets/auth_text_field.dart';
import 'package:task_track/features/user/user_providers.dart';
import 'package:task_track/features/dashboard/presentation/view/widgets/task_filter_field.dart';
import 'package:task_track/core/constants/app_colors.dart';
import 'package:task_track/features/user/presentation/view/widgets/user_form_section_header.dart';

class AddUserForm extends ConsumerWidget {
  const AddUserForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final presenter = ref.watch(addUserPresenterProvider.notifier);
    final state = ref.watch(addUserPresenterProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // SOLID Refinement: React to state changes instead of manual orchestration
    ref.listen(addUserPresenterProvider, (previous, next) {
      if (next.didSaveSuccessfully && !(previous?.didSaveSuccessfully ?? false)) {
        ref.read(userPresenterProvider.notifier).loadUsers();
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      }
    });

    return Form(
      key: presenter.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const UserFormSectionHeader(title: 'Users'),
          const SizedBox(height: 16),
          AuthTextField(
            label: 'Username*',
            hint: 'Username',
            controller: presenter.usernameController,
            validator: (v) => AuthHelper.validateRequired(v, 'Username'),
          ),
          const SizedBox(height: 16),
          AuthTextField(
            label: 'First Name*',
            hint: 'Enter the first name',
            controller: presenter.firstNameController,
            validator: (v) => AuthHelper.validateRequired(v, 'First name'),
          ),
          const SizedBox(height: 16),

          AuthTextField(
            label: 'Last Name*',
            hint: 'Enter the last name',
            controller: presenter.lastNameController,
            validator: (v) => AuthHelper.validateRequired(v, 'Last name'),
          ),
          const SizedBox(height: 16),

          AuthTextField(
            label: 'Email*',
            hint: 'Enter the email',
            controller: presenter.emailController,
            validator: AuthHelper.validateEmail,
          ),
          const SizedBox(height: 16),

          TaskFilterField(
            label: 'Role*',
            hint: 'Select role',
            value: presenter.selectedRole,
            isDark: isDark,
            width: double.infinity,
            options: const ['Associate', 'Manager', 'Admin'],
            onChanged: (v) => presenter.setRole(v),
          ),
          const SizedBox(height: 16),

          AuthTextField(
            label: 'Password*',
            hint: 'Password',
            controller: presenter.passwordController,
            obscureText: state.obscurePassword,
            validator: AuthHelper.validatePassword,
            suffixIcon: IconButton(
              icon: Icon(
                state.obscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                size: 20,
              ),
              onPressed: presenter.togglePassword,
            ),
          ),
          const SizedBox(height: 16),

          AuthTextField(
            label: 'Confirm Password*',
            hint: 'Confirm password',
            controller: presenter.confirmPasswordController,
            obscureText: state.obscureConfirmPassword,
            validator: (v) => AuthHelper.validateConfirmPassword(
              v,
              presenter.passwordController.text,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                state.obscureConfirmPassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                size: 20,
              ),
              onPressed: presenter.toggleConfirmPassword,
            ),
          ),
          const SizedBox(height: 16),

          TaskFilterField(
            label: 'Status*',
            hint: 'Select status',
            value: presenter.selectedStatus,
            isDark: isDark,
            width: double.infinity,
            options: const ['Active', 'Inactive'],
            onChanged: (v) => presenter.setStatus(v),
          ),

          const SizedBox(height: 40),

          /// ACTION BUTTONS
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    side: BorderSide(
                      color: Colors.redAccent.withValues(alpha: 0.5),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: state.isLoading ? null : presenter.createUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: state.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Save'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
