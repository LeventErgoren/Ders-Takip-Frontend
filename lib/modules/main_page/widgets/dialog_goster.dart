import 'package:ders_app/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool?> showSaveDialog() async {
  final isDark = Get.isDarkMode;
  final primary = isDark ? AppColors.primaryDark : AppColors.primaryLight;
  final background = isDark
      ? AppColors.backgroundDark
      : AppColors.backgroundLight;
  final textColor = isDark
      ? AppColors.textPrimaryDark
      : AppColors.textPrimaryLight;

  return await Get.dialog<bool?>(
    AlertDialog(
      backgroundColor: background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        'Çalışma Süresi',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: textColor,
          fontSize: 20,
        ),
      ),
      content: Text(
        'Çalışma sürenizi kaydetmek istiyor musunuz?',
        style: TextStyle(fontSize: 16, color: textColor),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(result: false),
          child: Text(
            'Hayır',
            style: TextStyle(
              color: isDark ? Colors.grey[300] : primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () => Get.back(result: true),
          child: const Text('Evet'),
        ),
      ],
    ),
    barrierDismissible: true,
  );
}
