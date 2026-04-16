import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:task_track/core/helpers/auth_helper.dart';
import 'package:task_track/features/auth/presentation/router/auth_router.dart';
import 'package:task_track/features/auth/presentation/view/widgets/auth_text_field.dart';
import 'package:task_track/features/auth/auth_providers.dart';
import 'package:task_track/features/auth/presentation/presenter/signup_presenter.dart';
import 'package:task_track/features/auth/presentation/view/widgets/auth_header.dart';
import 'package:task_track/features/auth/presentation/view/widgets/auth_footer.dart';
import 'package:task_track/features/auth/presentation/view/widgets/auth_submit_button.dart';
import 'package:task_track/features/auth/presentation/view/widgets/auth_theme_toggle.dart';
import 'package:task_track/features/auth/presentation/view/widgets/auth_view_handler.dart';

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
                    title: 'Create your account',
                    subtitle: 'Please enter your details.',
                    isDark: isDark,
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
                                  ? Colors.white54
                                  : Colors.grey,
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
                                  ? Colors.white54
                                  : Colors.grey,
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
                        AuthSubmitButton(
                          text: 'Create account',
                          isLoading: state.isLoading,
                          onPressed: presenter.signup,
                        ),

                        const SizedBox(height: 32),

                        /// Footer
                        AuthFooter(
                          text: "Already have an account? ",
                          actionText: 'Sign in',
                          isDark: isDark,
                          onTap: () => context.go(AuthRouter.login),
                        ),

                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// Theme Toggle
            AuthThemeToggle(isDark: isDark),
          ],
        ),
      ),
    );
  }
}