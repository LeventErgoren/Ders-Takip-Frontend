import 'dart:async';
import 'package:ders_app/core/base_controller.dart';
import 'package:get/get.dart';

class MainPageController extends BaseController {
  var elapsed = Duration.zero.obs;
  var isRunning = false.obs;

  Timer? _timer;
  DateTime? _startTime;

  void start() {
    if (isRunning.value) return;

    isRunning.value = true;
    _startTime = DateTime.now().subtract(elapsed.value);

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final now = DateTime.now();
      elapsed.value = now.difference(_startTime!);
    });
  }

  void stop() {
    if (!isRunning.value) return;

    isRunning.value = false;
    _timer?.cancel();
  }

  void reset() {
    stop();
    elapsed.value = Duration.zero;
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
