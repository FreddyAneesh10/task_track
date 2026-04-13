import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user_entity.dart';
import '../../interactor/login_interactor.dart';

abstract class BaseAuthState {
  bool get isLoading;
  String? get error;
}

class LoginState implements BaseAuthState {
  @override
  final bool isLoading;
  @override
  final String? error;
  final UserEntity? user;
  final bool obscurePassword;

  const LoginState({
    this.isLoading = false,
    this.error,
    this.user,
    this.obscurePassword = true,
  });

  LoginState copyWith({
    bool? isLoading,
    String? error,
    UserEntity? user,
    bool? obscurePassword,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      user: user ?? this.user,
      obscurePassword: obscurePassword ?? this.obscurePassword,
    );
  }
}

class LoginPresenter extends StateNotifier<LoginState> {
  final LoginInteractor _loginInteractor;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  LoginPresenter(this._loginInteractor) : super(const LoginState());

  void togglePassword() {
    state = state.copyWith(obscurePassword: !state.obscurePassword);
  }

  Future<bool> login() async {
    if (!formKey.currentState!.validate()) return false;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final user = await _loginInteractor.execute(
        usernameController.text.trim(),
        passwordController.text.trim(),
      );
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
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
