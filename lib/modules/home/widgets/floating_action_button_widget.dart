import 'package:flutter/material.dart';
import 'package:ders_app/themes/app_colors.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  const FloatingActionButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode
        ? AppColors.accentDark
        : AppColors.accentLight;
    final iconColor = Colors.white;

    return FloatingActionButton(
      onPressed: () {},
      shape: const CircleBorder(),
      backgroundColor: backgroundColor,
      child: Icon(Icons.add, color: iconColor, size: 28),
      elevation: 6,
      tooltip: 'Yeni Ekle',
    );
  }
}
