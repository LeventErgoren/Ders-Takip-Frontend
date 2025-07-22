import 'dart:async';
import 'dart:isolate';

import 'package:flutter_foreground_task/flutter_foreground_task.dart';

class MyTaskHandler extends TaskHandler {
  Timer? _timer;
  DateTime? _startTime;
  SendPort? _sendPort;

  @override
  void onStart(DateTime timestamp, SendPort? sendPort) {
    _sendPort = sendPort;
    _startTime = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final elapsed = DateTime.now().difference(_startTime!);
      _sendPort?.send(elapsed.inSeconds);

      FlutterForegroundTask.updateService(
        notificationTitle: 'Ders Sayacı Aktif',
        notificationText: 'Çalışma süresi: ${formatDuration(elapsed)}',
      );
    });
  }

  @override
  void onDestroy(DateTime timestamp, SendPort? sendPort) {
    _timer?.cancel();
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
    // TODO: implement onRepeatEvent
  }
}
