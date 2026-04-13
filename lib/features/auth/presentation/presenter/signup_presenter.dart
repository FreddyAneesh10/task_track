import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/entities/signup_request.dart';
import '../../interactor/signup_interactor.dart';
import 'login_presenter.dart'; // To get BaseAuthState

class SignupState implements BaseAuthState {
  @override
  final bool isLoading;
  @override
  final String? error;
  final UserEntity? user;
  final bool obscurePassword;
  final bool obscureConfirmPassword;

  const SignupState({
    this.isLoading = false,
    this.error,
    this.user,
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
  });

  SignupState copyWith({
    bool? isLoading,
    String? error,
    UserEntity? user,
    bool? obscurePassword,
    bool? obscureConfirmPassword,
  }) {
    return SignupState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      user: user ?? this.user,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword:
          obscureConfirmPassword ?? this.obscureConfirmPassword,
    );
  }
}

class SignupPresenter extends StateNotifier<SignupState> {
  final SignupInteractor _signupInteractor;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final orgController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  SignupPresenter(this._signupInteractor) : super(const SignupState());

  void togglePassword() {
    state = state.copyWith(obscurePassword: !state.obscurePassword);
  }

  void toggleConfirmPassword() {
    state = state.copyWith(
        obscureConfirmPassword: !state.obscureConfirmPassword);
  }

  Future<bool> signup() async {
    if (!formKey.currentState!.validate()) return false;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final request = SignupRequest(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        username: usernameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        orgName: orgController.text.trim(),
      );

      final user = await _signupInteractor.execute(request);
      state = state.copyWith(isLoading: false, user: user);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString().replaceAll('Exception: ', ''),
      );
      return false;
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    orgController.dispose();
    super.dispose();
  }
}
