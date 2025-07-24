import 'dart:async';
import 'dart:isolate';

import 'package:ders_app/services/storage_service.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyTaskHandler extends TaskHandler {
  Timer? _timer;
  DateTime? _startTime;
  SendPort? _sendPort;
  late SharedPreferences _service;
  bool _isPaused = false;

  @override
  void onStart(DateTime timestamp, SendPort? sendPort) async {
    _timer?.cancel();
    _sendPort = sendPort;
    _service = await SharedPreferences.getInstance();

    final savedStartTimeString = _service.getString(
      StorageKeys.notificationSavedStartTime,
    );

    if (savedStartTimeString != null) {
      _startTime = DateTime.parse(savedStartTimeString);
    } else {
      _startTime = DateTime.now();
      await _service.setString(
        StorageKeys.notificationSavedStartTime,
        _startTime!.toIso8601String(),
      );
    }

    _isPaused = false;
    _startTimer();
  }

  void _startTimer() {
    // Önceki timer varsa iptal et
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (_isPaused || _startTime == null) return;

      final elapsed = DateTime.now().difference(_startTime!);
      _sendPort?.send(elapsed.inSeconds);

      // Bildirimi güncelle, await yaparken dikkatli ol
      await FlutterForegroundTask.updateService(
        notificationTitle: 'Ders Sayacı Aktif',
        notificationText: 'Çalışma süresi: ${formatDuration(elapsed)}',
      );
    });
  }

  @override
  void onDestroy(DateTime timestamp, SendPort? sendPort) {
    _timer?.cancel();
  }

  @override
  void onButtonPressed(String id) async {
    if (id == 'pause_or_resume') {
      _isPaused = !_isPaused;

      if (_isPaused) {
        // Duraklat: timer iptal edilir
        _timer?.cancel();

        await FlutterForegroundTask.updateService(
          notificationTitle: 'Ders Sayacı Durdu',
          notificationText: 'Sayaç duraklatıldı',
        );
      } else {
        // Devam ettir: eğer startTime yoksa şimdi ata
        if (_startTime == null) {
          _startTime = DateTime.now();
          await _service.setString(
            StorageKeys.notificationSavedStartTime,
            _startTime!.toIso8601String(),
          );
        }
        _startTimer();

        await FlutterForegroundTask.updateService(
          notificationTitle: 'Ders Sayacı Aktif',
          notificationText:
              'Sayaç devam ediyor: ${formatDuration(DateTime.now().difference(_startTime!))}',
        );
      }
    } else if (id == 'reset') {
      // Reset: timer iptal, zaman sıfırla, shared preferences temizle
      _timer?.cancel();
      _startTime = null;
      _isPaused = false;
      await _service.remove(StorageKeys.notificationSavedStartTime);

      await FlutterForegroundTask.updateService(
        notificationTitle: 'Sayaç Sıfırlandı',
        notificationText: 'Süre: 00:00:00',
      );
    }
  }

  String formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final h = twoDigits(d.inHours);
    final m = twoDigits(d.inMinutes.remainder(60));
    final s = twoDigits(d.inSeconds.remainder(60));
    return '$h:$m:$s';
  }

  @override
  void onRepeatEvent(DateTime timestamp, SendPort? sendPort) {
    // İstersen bu kısmı ileride kullanabilirsin
  }
}
