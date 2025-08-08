import 'package:ders_app/repositories/calisma_suresi_repository.dart';
import 'package:ders_app/services/api_service.dart';
import 'package:ders_app/services/auth_service.dart';
import 'package:ders_app/services/connectivity_service.dart';
import 'package:ders_app/services/storage_service.dart';
import 'package:ders_app/services/theme_service.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  Future<void> dependencies() async {
    Get.put(ConnectivityService(),permanent: true);

    await Get.putAsync<StorageService>(() async {
      final service = StorageService();
      await service.init();
      return service;
    });

    await Get.putAsync<ApiService>(() async {
      final service = ApiService();
      await service.init();
      return service;
    });

    await Get.putAsync<AuthService>(() async {
      final service = AuthService();
      await service.init();
      return service;
    });

    await Get.putAsync<ThemeService>(() async {
      final service = ThemeService();
      await service.init();
      return service;
    });
    Get.put(CalismaSuresiRepository());
  }
}
