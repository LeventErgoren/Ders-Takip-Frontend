import 'package:ders_app/core/base_controller.dart';
import 'package:ders_app/models/maintenance.dart';
import 'package:ders_app/modules/maintenance/maintenance_page.dart';
import 'package:ders_app/services/api_service.dart';
import 'package:ders_app/services/auth_service.dart';
import 'package:ders_app/services/storage_service.dart';
import 'package:ders_app/services/theme_service.dart';
import 'package:get/get.dart';

class SplashController extends BaseController {
  late AuthService _service;

  @override
  void onReady() async {
    super.onReady();
    await waitForServices();
    _service = Get.find<AuthService>();

    Maintenance? maintenance = await _service.isMaintenance();
    if (maintenance == null || maintenance.maintenance) {
      Get.offAll(() => MaintenanceView(maintenance: maintenance));
    } else {
      await checkTokenAndRedirect();
    }
  }

  Future<void> waitForServices() async {
    while (!Get.isRegistered<ApiService>() ||
        !Get.isRegistered<AuthService>() ||
        !Get.isRegistered<StorageService>() ||
        !Get.isRegistered<ThemeService>()) {
      await Future.delayed(Duration(milliseconds: 300));
    }
  }

  Future<void> checkTokenAndRedirect() async {
    _service = Get.find<AuthService>();
    await _service.checkToken();
  }
}
