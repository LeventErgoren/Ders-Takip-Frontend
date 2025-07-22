import 'dart:async';
import 'package:ders_app/core/base_controller.dart';
import 'package:ders_app/modules/home/home_controller.dart';
import 'package:ders_app/modules/main_page/my_task_handler.dart';
import 'package:ders_app/modules/main_page/widgets/dialog_goster.dart';
import 'package:ders_app/repositories/calisma_suresi_repository.dart';
import 'package:ders_app/services/auth_service.dart';
import 'package:ders_app/services/storage_service.dart';
import 'package:ders_app/start/main.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:get/get.dart';

class MainPageController extends BaseController {
  var elapsed = Duration.zero.obs;
  var isRunning = false.obs;
  late CalismaSuresiRepository _service;
  late AuthService _authService;
  late HomeController _homeController;
  late StorageService _storage;

  Timer? _timer;
  DateTime? _startTime;

  void start() async {
    if (isRunning.value) return;

    DateTime now = DateTime.now();
    String dateTimeString = now.toIso8601String();
    try {
      await FlutterForegroundTask.startService(
        notificationTitle: 'Ders Sayacı Aktif',
        notificationText: 'Çalışma süresi: 00:00:00',
        callback: startCallback,
      );
    } catch (e) {
      print('Foreground service başlatılırken hata: $e');
    }
    await _storage.setValue<String>(StorageKeys.savedStartTime, dateTimeString);
    isRunning.value = true;
    _startTime = DateTime.now().subtract(elapsed.value);

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final now = DateTime.now();
      elapsed.value = now.difference(_startTime!);

      FlutterForegroundTask.updateService(
        notificationTitle: 'Ders Sayacı Aktif',
        notificationText: 'Çalışma süresi: ${_formatDuration(elapsed.value)}',
      );
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }

  void stop() {
    if (!isRunning.value) return;

    isRunning.value = false;
    _timer?.cancel();
  }

  void reset() async {
    if (elapsed.value.inSeconds != 0) {
      bool? isConfirm = await showSaveDialog();
      if (isConfirm == true) {
        if (elapsed.value.inMinutes != 0) {
          await _service.addCalismaSuresi(
            _authService.userId.value,
            elapsed.value.inMinutes,
          );
          await _homeController.calismaSuresiGuncelle();
        } else {
          showError("1 Dakikadan az çalışma süreleri kayıt edilmez!");
        }
      } else if (isConfirm == false) {
        print("Hayır");
      } else {
        print("Kullanıcı hiçbir şey yapmadı");
        return;
      }

      await _storage.remove(StorageKeys.savedStartTime);
      stop();
      elapsed.value = Duration.zero;
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    _service = Get.find<CalismaSuresiRepository>();
    _authService = Get.find<AuthService>();
    _homeController = Get.find<HomeController>();
    _storage = Get.find<StorageService>();
    String? savedTimeString = _storage.getValue(StorageKeys.savedStartTime);
    if (savedTimeString != null) {
      final now = DateTime.now();
      DateTime startTime = DateTime.parse(savedTimeString);
      elapsed.value = now.difference(startTime);
      isRunning.value = true;
      _startTime = startTime;

      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        final now = DateTime.now();
        elapsed.value = now.difference(_startTime!);
      });
    }
  }
}
