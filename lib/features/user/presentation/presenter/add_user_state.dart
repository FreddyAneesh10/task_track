class AddUserState {
  final bool isLoading;
  final String? errorMessage;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final bool didSaveSuccessfully;

  const AddUserState({
    this.isLoading = false,
    this.errorMessage,
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
    this.didSaveSuccessfully = false,
  });

  AddUserState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    bool? didSaveSuccessfully,
  }) {
    return AddUserState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword: obscureConfirmPassword ?? this.obscureConfirmPassword,
      didSaveSuccessfully: didSaveSuccessfully ?? this.didSaveSuccessfully,
    );
  }
}
