import 'package:ders_app/modules/add_calisma/add_calisma_controller.dart';
import 'package:ders_app/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectDate extends GetView<AddCalismaController> {
  const SelectDate({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;
    final bgColor = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final borderColor = Theme.of(context).colorScheme.outlineVariant;
    return GestureDetector(
      onTap: () => controller.selectDateWithTheme(context),
      child: Obx(() {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: bgColor,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                controller.formatDate(),
                style: TextStyle(color: textColor, fontSize: 16),
              ),
              Icon(Icons.calendar_today_outlined, color: textColor),
            ],
          ),
        );
      }),
    );
  }
}
