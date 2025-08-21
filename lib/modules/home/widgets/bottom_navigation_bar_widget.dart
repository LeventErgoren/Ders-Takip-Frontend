import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:ders_app/modules/home/home_controller.dart';
import 'package:ders_app/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigationBarWidget extends GetView<HomeController> {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final activeColor = isDarkMode
        ? AppColors.accentDark
        : AppColors.accentLight;
    final inactiveColor = isDarkMode
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;
    final bgColor = isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight;

    return Obx(() {
      return AnimatedBottomNavigationBar.builder(
        itemCount: controller.iconList.length,
        activeIndex: controller.activeIndex.value,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.smoothEdge,
        leftCornerRadius: 24,
        rightCornerRadius: 24,
        backgroundColor: bgColor,
        splashColor: activeColor.withOpacity(0.1),
        splashSpeedInMilliseconds: 250,
        elevation: 8,
        tabBuilder: (index, isActive) {
          final color = isActive ? activeColor : inactiveColor;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  controller.iconList[index],
                  size: isActive ? 30 : 24,
                  color: color,
                ),
                const SizedBox(height: 4),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 3,
                  width: isActive ? 20 : 0,
                  decoration: BoxDecoration(
                    color: activeColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          );
        },
        onTap: (index) {
          controller.activeIndex.value = index;
        },
      );
    });
  }
}
