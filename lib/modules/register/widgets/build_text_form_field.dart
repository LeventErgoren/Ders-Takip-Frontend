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
  return TextFormField(
    onSaved: onSaved,
    validator: validator,
    obscureText: obscure,
    keyboardType: inputType,
    style: TextStyle(color: theme.colorScheme.onSurface),
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.6)),
      prefixIcon: Icon(icon, color: theme.colorScheme.onSurface),
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: theme.colorScheme.primary.withOpacity(0.4),
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: theme.colorScheme.primary.withOpacity(0.4),
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      filled: false, // input içi şeffaf olacak
    ),
  );
}
