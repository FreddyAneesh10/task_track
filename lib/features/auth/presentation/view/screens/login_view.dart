import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:task_track/core/constants/app_colors.dart';
import 'package:task_track/features/auth/presentation/router/auth_router.dart';
import 'package:task_track/features/auth/presentation/view/widgets/auth_logo.dart';
import 'package:task_track/features/auth/presentation/view/widgets/auth_text_field.dart';
import 'package:task_track/core/helpers/auth_helper.dart';
import 'package:task_track/features/auth/auth_providers.dart';
import 'package:task_track/features/auth/presentation/view/widgets/auth_view_handler.dart';
import 'package:task_track/core/theme/theme_provider.dart';
import 'package:task_track/features/auth/presentation/presenter/login_presenter.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> with AuthViewHandler {
  @override
  Widget build(BuildContext context) {
    listenToAuthState(context, ref, loginPresenterProvider);
    final LoginState state = ref.watch(loginPresenterProvider);
    final LoginPresenter presenter = ref.watch(loginPresenterProvider.notifier);
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
                      'Welcome back',
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
                        AuthTextField(
                          label: 'Email',
                          hint: 'Enter your email',
                          controller: presenter.usernameController,
                          validator: (v) =>
                              AuthHelper.validateRequired(v, 'Email'),
                        ),
                        const SizedBox(height: 20),
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

                        // Actions Row
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text('Forgot password'),
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Sign In Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed:
                                state.isLoading ? null : presenter.login,
                            child: state.isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text('Sign in'),
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Footer
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: isDark
                                    ? AppColors.textSecondary
                                    : AppColors.textSubheader,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => context.go(AuthRouter.signup),
                              child: Text(
                                'Sign up',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Theme Toggle (Placed last to be on top and clickable)
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
