import 'package:flutter/material.dart';

class PasswordToggle extends StatelessWidget {
  final bool showPassword;
  final VoidCallback onToggle;
  const PasswordToggle({
    super.key,
    required this.showPassword,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onToggle,
      icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
    );
  }
}
