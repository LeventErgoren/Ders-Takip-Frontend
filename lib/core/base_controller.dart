import 'package:ders_app/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseController extends GetxController {
  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  void setLoading(bool value) => _isLoading.value = value;

  void showSuccess(String message) {
    Get.closeCurrentSnackbar();
    _showSnackbar(
      message,
      icon: Icons.check_circle_outline,
      backgroundColor: Get.isDarkMode
          ? AppColors.surfaceDark
          : AppColors.surfaceLight,
      iconColor: Colors.greenAccent,
      textColor: Get.isDarkMode ? Colors.green[200]! : Colors.green[800]!,
    );
  }

  void showError(String message) {
    Get.closeCurrentSnackbar();
    _showSnackbar(
      message,
      icon: Icons.error_outline,
      backgroundColor: Get.isDarkMode
          ? AppColors.surfaceDark
          : AppColors.surfaceLight,
      iconColor: Colors.redAccent,
      textColor: Get.isDarkMode ? Colors.red[200]! : Colors.red[800]!,
    );
  }

  void _showSnackbar(
    String message, {
    required IconData icon,
    required Color backgroundColor,
    required Color iconColor,
    required Color textColor,
  }) {
    Get.snackbar(
      '',
      '',
      titleText: const SizedBox.shrink(),
      messageText: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Yatay ortalama
          crossAxisAlignment: CrossAxisAlignment.center, // Dikey ortalama
          mainAxisSize: MainAxisSize.min, // Row genişliğini içeriğe göre ayarla
          children: [
            Icon(icon, color: iconColor, size: 24),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: backgroundColor,
      borderRadius: 16,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      snackPosition: SnackPosition.BOTTOM,
      animationDuration: const Duration(milliseconds: 400),
      duration: const Duration(seconds: 3),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }
}
