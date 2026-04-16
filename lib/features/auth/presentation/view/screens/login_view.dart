import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:task_track/features/auth/presentation/router/auth_router.dart';
import 'package:task_track/features/auth/presentation/view/widgets/auth_text_field.dart';
import 'package:task_track/core/helpers/auth_helper.dart';
import 'package:task_track/features/auth/auth_providers.dart';
import 'package:task_track/features/auth/presentation/view/widgets/auth_view_handler.dart';
import 'package:task_track/features/auth/presentation/presenter/login_presenter.dart';
import 'package:task_track/features/auth/presentation/view/widgets/auth_header.dart';
import 'package:task_track/features/auth/presentation/view/widgets/auth_footer.dart';
import 'package:task_track/features/auth/presentation/view/widgets/auth_submit_button.dart';
import 'package:task_track/features/auth/presentation/view/widgets/auth_theme_toggle.dart';

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
      backgroundColor: isDark ? Colors.black : Colors.grey.shade50,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AuthHeader(
                    title: 'Welcome back',
                    subtitle: 'Please enter your details.',
                    isDark: isDark,
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
                                  ? Colors.white54
                                  : Colors.grey,
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
                        AuthSubmitButton(
                          text: 'Sign in',
                          isLoading: state.isLoading,
                          onPressed: presenter.login,
                        ),
                        const SizedBox(height: 32),

                        // Footer
                        AuthFooter(
                          text: "Don't have an account? ",
                          actionText: 'Sign up',
                          isDark: isDark,
                          onTap: () => context.go(AuthRouter.signup),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Theme Toggle
            AuthThemeToggle(isDark: isDark),
          ],
        ),
      ),
    );
  }
}
