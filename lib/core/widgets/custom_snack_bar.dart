import 'package:flutter/material.dart';

class CustomSnackBar {
  static void show(
     {
    required String message,
    required BuildContext context,
    Color backgroundColor = Colors.black,
    IconData? icon,
    Duration duration = const Duration(seconds: 3),
  }) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          if (icon != null)
            Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          if (icon != null) const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      duration: duration,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.all(16),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}