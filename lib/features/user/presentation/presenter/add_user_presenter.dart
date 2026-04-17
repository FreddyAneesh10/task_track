import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_track/features/user/interactor/user_interactor.dart';
import 'package:task_track/features/user/presentation/presenter/add_user_state.dart';

class AddUserPresenter extends StateNotifier<AddUserState> {
  final UserInteractor _interactor;

  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  
  String selectedRole = 'Associate';
  String selectedStatus = 'Active';

  AddUserPresenter(this._interactor) : super(const AddUserState());

  void togglePassword() {
    state = state.copyWith(obscurePassword: !state.obscurePassword);
  }

  void toggleConfirmPassword() {
    state = state.copyWith(obscureConfirmPassword: !state.obscureConfirmPassword);
  }

  void setRole(String role) {
    selectedRole = role;
  }

  void setStatus(String status) {
    selectedStatus = status;
  }

  Future<bool> createUser() async {
    if (!formKey.currentState!.validate()) return false;

    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      didSaveSuccessfully: false,
    );
    try {
      await _interactor.registerNewUser(
        username: usernameController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        role: selectedRole,
        status: selectedStatus,
        password: passwordController.text,
      );
      state = state.copyWith(isLoading: false, didSaveSuccessfully: true);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return false;
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
