import 'package:ders_app/core/base_controller.dart';
import 'package:ders_app/modules/routes/app_pages.dart';
import 'package:ders_app/services/api_service.dart';
import 'package:ders_app/services/auth_service.dart';
import 'package:ders_app/services/storage_service.dart';
import 'package:get/get.dart';

class SplashController extends BaseController {
  @override
  void onReady() async {
    super.onReady();
    await waitForServices();
    await checkTokenAndRedirect();
  }

  Future<void> waitForServices() async {
    while (!Get.isRegistered<ApiService>() ||
        !Get.isRegistered<AuthService>() ||
        !Get.isRegistered<StorageService>()) {
      await Future.delayed(Duration(milliseconds: 300));
    }
  }

  Future<void> checkTokenAndRedirect() async {
    final _authService = Get.find<AuthService>();
    final isAuthenticated = await _authService.isAuthenticated();

    if (isAuthenticated) {
      Get.offAllNamed(AppRoutes.HOME);
    } else {
      Get.offAllNamed(AppRoutes.LOGIN);
    }
  }
}
