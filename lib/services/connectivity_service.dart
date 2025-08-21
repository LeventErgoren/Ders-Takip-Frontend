import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectivityService extends GetxService {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();

    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(List<ConnectivityResult> event) {
    if (event.contains(ConnectivityResult.none)) {
      Get.snackbar(
        '',
        '',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.isDarkMode
            ? Colors.red.shade900
            : Colors.red.shade100,
        margin: const EdgeInsets.all(12),
        borderRadius: 12,
        isDismissible: false,
        titleText: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            "Bağlantı Hatası",
            style: TextStyle(
              color: Get.isDarkMode ? Colors.red.shade100 : Colors.red.shade900,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        messageText: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            "İnternet bağlantınız yok",
            style: TextStyle(
              color: Get.isDarkMode ? Colors.red.shade100 : Colors.red.shade900,
              fontSize: 14,
            ),
          ),
        ),
        icon: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Icon(
            Icons.wifi_off,
            color: Get.isDarkMode ? Colors.red.shade100 : Colors.red.shade900,
          ),
        ),
        duration: const Duration(days: 1),
      );
    } else {
      Get.closeCurrentSnackbar();
    }
  }
}
