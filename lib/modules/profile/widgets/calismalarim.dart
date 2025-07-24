import 'package:ders_app/modules/routes/app_pages.dart';
import 'package:ders_app/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalismalarimButonu extends StatelessWidget {
  const CalismalarimButonu({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return ListTile(
      leading: Icon(
        Icons.access_time,
        color: isDarkMode
            ? AppColors.textPrimaryDark
            : AppColors.textSecondaryLight,
      ),
      title: const Text("Çalışmalarım"),
      onTap: () {
        Get.toNamed(AppRoutes.TIME); // ya da senin çalışmalar sayfanın route'u
      },
    );
  }
}
