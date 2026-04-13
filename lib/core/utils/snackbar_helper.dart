import 'package:flutter/material.dart';

class SnackbarHelper {
  SnackbarHelper._();

  /// Default SnackBar
  static void show(
    BuildContext context, {
    required String message,
    Color? backgroundColor,
    Duration duration = const Duration(seconds: 2),
  }) {
    _hideCurrent(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor ?? Colors.black,
        duration: duration,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Success SnackBar
  static void success(BuildContext context, String message) {
    show(
      context,
      message: message,
      backgroundColor: Colors.green,
    );
  }

  /// Error SnackBar
  static void error(BuildContext context, String message) {
    show(
      context,
      message: message,
      backgroundColor: Colors.red,
    );
  }

  /// Info SnackBar
  static void info(BuildContext context, String message) {
    show(
      context,
      message: message,
      backgroundColor: Colors.blue,
    );
  }

  /// Hide current snackbar
  static void _hideCurrent(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}