import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:task_track/core/constants/app_colors.dart';
import 'package:task_track/core/helpers/auth_helper.dart';
import 'package:task_track/features/auth/presentation/router/auth_router.dart';
import 'package:task_track/features/auth/presentation/view/widgets/auth_logo.dart';
import 'package:task_track/features/auth/presentation/view/widgets/auth_text_field.dart';
import 'package:task_track/features/auth/presentation/view/widgets/auth_view_handler.dart';
import 'package:task_track/core/theme/theme_provider.dart';
import 'package:task_track/features/auth/auth_providers.dart';
import 'package:task_track/features/auth/presentation/presenter/signup_presenter.dart';

class SignupView extends ConsumerStatefulWidget {
  const SignupView({super.key});

  @override
  ConsumerState<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends ConsumerState<SignupView> with AuthViewHandler {
  @override
  Widget build(BuildContext context) {
    listenToAuthState(context, ref, signupPresenterProvider);
    final SignupState state = ref.watch(signupPresenterProvider);
    final SignupPresenter presenter =
        ref.watch(signupPresenterProvider.notifier);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),

                  // Logo
                  const Center(child: AuthLogo()),

                  Center(
                    child: Text(
                      'Create your account',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Center(
                    child: Text(
                      'Please enter your details.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isDark
                            ? AppColors.textSecondary
                            : AppColors.textSubheader,
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  Form(
                    key: presenter.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Name Row
                        Row(
                          children: [
                            Expanded(
                              child: AuthTextField(
                                label: 'First Name',
                                hint: 'First name',
                                controller: presenter.firstNameController,
                                validator: (v) => AuthHelper.validateRequired(
                                  v,
                                  'First name',
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: AuthTextField(
                                label: 'Last Name',
                                hint: 'Last name',
                                controller: presenter.lastNameController,
                                validator: (v) =>
                                    AuthHelper.validateRequired(v, 'Last name'),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        /// Username
                        AuthTextField(
                          label: 'Username',
                          hint: 'Enter your username',
                          controller: presenter.usernameController,
                          validator: (v) =>
                              AuthHelper.validateRequired(v, 'Username'),
                        ),

                        const SizedBox(height: 20),

                        /// Email
                        AuthTextField(
                          label: 'Email',
                          hint: 'Enter your email',
                          controller: presenter.emailController,
                          validator: AuthHelper.validateEmail,
                        ),

                        const SizedBox(height: 20),

                        /// Password
                        AuthTextField(
                          label: 'Password',
                          hint: 'Enter your password',
                          controller: presenter.passwordController,
                          obscureText: state.obscurePassword,
                          validator: AuthHelper.validatePassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              state.obscurePassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              size: 20,
                              color: isDark
                                  ? AppColors.textTertiary
                                  : AppColors.textSubheader,
                            ),
                            onPressed: presenter.togglePassword,
                          ),
                        ),

                        const SizedBox(height: 20),

                        /// Confirm Password
                        AuthTextField(
                          label: 'Confirm Password',
                          hint: 'Confirm your password',
                          controller: presenter.confirmPasswordController,
                          obscureText: state.obscureConfirmPassword,
                          validator: (v) => AuthHelper.validateConfirmPassword(
                            v,
                            presenter.passwordController.text,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              state.obscureConfirmPassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              size: 20,
                              color: isDark
                                  ? AppColors.textTertiary
                                  : AppColors.textSubheader,
                            ),
                            onPressed: presenter.toggleConfirmPassword,
                          ),
                        ),

                        const SizedBox(height: 20),

                        /// Organisation
                        AuthTextField(
                          label: 'Organisation',
                          hint: 'Enter your organisation name',
                          controller: presenter.orgController,
                          validator: (v) => AuthHelper.validateRequired(
                            v,
                            'Organisation name',
                          ),
                        ),

                        const SizedBox(height: 32),

                        /// Signup Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed:
                                state.isLoading ? null : presenter.signup,
                            child: state.isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text('Create account'),
                          ),
                        ),

                        const SizedBox(height: 32),

                        /// Footer
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account? ",
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: isDark
                                    ? AppColors.textSecondary
                                    : AppColors.textSubheader,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => context.go(AuthRouter.login),
                              child: Text(
                                'Sign in',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// Theme Toggle
            Positioned(
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
            ),
          ],
        ),
      ),
    );
  }
}