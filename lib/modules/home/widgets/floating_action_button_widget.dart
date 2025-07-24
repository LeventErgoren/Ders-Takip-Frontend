import 'package:ders_app/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:ders_app/themes/app_colors.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class FloatingActionButtonWidget extends GetView<HomeController> {
  const FloatingActionButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode
        ? AppColors.accentDark
        : AppColors.accentLight;
    final iconColor = Colors.white;

    return FloatingActionButton(
      onPressed: controller.addTime,
      shape: const CircleBorder(),
      backgroundColor: backgroundColor,
      elevation: 6,
      tooltip: 'Yeni Ekle',
      child: Icon(Icons.add, color: iconColor, size: 28),
    );
  }
}
