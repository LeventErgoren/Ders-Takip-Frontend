import 'package:flutter/material.dart';

Widget buildCard(BuildContext context, String date, int dakika) {
  final theme = Theme.of(context);
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    color: theme.cardTheme.color,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(date, style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16)),
          Text(
            '$dakika dk',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    ),
  );
}
