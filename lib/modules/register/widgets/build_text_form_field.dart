import 'package:flutter/material.dart';

Widget buildLabel(String text, ThemeData theme) {
  return Text(text, style: theme.textTheme.labelLarge);
}

Widget buildTextField(
  ThemeData theme, {
  required String hint,
  required IconData icon,
  required void Function(String?) onSaved,
  String? Function(String?)? validator,
  bool obscure = false,
  TextInputType inputType = TextInputType.text,
}) {
  // Temadan gelen InputDecorationTheme'i al
  final inputTheme = theme.inputDecorationTheme;

  return TextFormField(
    onSaved: onSaved,
    validator: validator,
    obscureText: obscure,
    keyboardType: inputType,
    style: theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurface,
    ),
    decoration: InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: inputTheme.prefixIconColor),
    ),
  );
}
