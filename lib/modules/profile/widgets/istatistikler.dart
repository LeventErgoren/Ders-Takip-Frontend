import 'package:ders_app/modules/routes/app_pages.dart';
import 'package:ders_app/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IstatistiklerButonu extends StatelessWidget {
  const IstatistiklerButonu({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return ListTile(
      leading: Icon(
        Icons.bar_chart,
        color: isDarkMode
            ? AppColors.textPrimaryDark
            : AppColors.textSecondaryLight,
      ),
      title: Text("İstatistikler"),
      onTap: () {
        Get.toNamed(AppRoutes.STATISTICS);
      },
    );
  }
}
