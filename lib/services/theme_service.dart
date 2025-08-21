import 'package:ders_app/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeService extends GetxService {
  late final StorageService _service;
  final _isDarkMode = false.obs;
  bool get isDarkMode => _isDarkMode.value;

  Future<void> init() async {
    _service = Get.find<StorageService>();
    await loadThemeMode();
  }

  Future<void> loadThemeMode() async {
    final savedTheme = _service.getValue<String>(StorageKeys.themeMode);
    if (savedTheme != null) {
      _isDarkMode.value = savedTheme == "dark";
      _changeTheme();
    } else {
      final brightness = Get.theme.brightness;
      _isDarkMode.value = brightness == Brightness.dark;
      await _setTheme();
      _changeTheme();
    }
  }

  Future<void> toogleTheme() async {
    _isDarkMode.value = !_isDarkMode.value;
    _changeTheme();
    await _setTheme();
  }

  void _changeTheme() {
    Get.changeThemeMode(_isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> _setTheme() async {
    await _service.setValue(
      StorageKeys.themeMode,
      isDarkMode ? "dark" : "light",
    );
  }
}
