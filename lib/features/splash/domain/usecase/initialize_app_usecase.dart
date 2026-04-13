import 'dart:async';

class InitializeAppUseCase {
  Future<void> execute() async {
    // Simulate application initialization (loading configs, checking auth, etc.)
    await Future.delayed(const Duration(seconds: 3));
  }
}
