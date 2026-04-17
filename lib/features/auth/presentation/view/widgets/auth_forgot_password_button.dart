import 'package:flutter/material.dart';

class AuthForgotPasswordButton extends StatelessWidget {
  final VoidCallback onTap;

  const AuthForgotPasswordButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: onTap,
        child: const Text('Forgot password'),
      ),
    );
  }
}
