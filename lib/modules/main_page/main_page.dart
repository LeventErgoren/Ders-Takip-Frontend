import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:ders_app/modules/main_page/main_page_controller.dart';

class MainPage extends GetView<MainPageController> {
  MainPage({super.key});

  String formatTime(Duration d) {
    String two(int n) => n.toString().padLeft(2, '0');
    return "${two(d.inHours)}:${two(d.inMinutes.remainder(60))}:${two(d.inSeconds.remainder(60))}";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primary = theme.colorScheme.primary;
    final secondary = theme.colorScheme.secondary;
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      body: Center(
        child: Obx(() {
          final elapsed = controller.elapsed.value;
          final isRunning = controller.isRunning.value;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Sayaç metni
              Text(
                formatTime(elapsed),
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 60),

              // Butonlar
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Başlat / Durdur Toggle Butonu
                  ElevatedButton.icon(
                    icon: Icon(
                      isRunning
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_fill,
                      size: 28,
                    ),
                    label: Text(
                      isRunning ? "Durdur" : "Başlat",
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      backgroundColor: primary,
                      foregroundColor: Colors.white,
                      elevation: 6,
                    ),
                    onPressed: isRunning ? controller.stop : controller.start,
                  ),
                  const SizedBox(width: 24),

                  // Bitir Butonu (Outline)
                  OutlinedButton.icon(
                    icon: const Icon(Icons.stop_circle_outlined, size: 28),
                    label: const Text("Bitir", style: TextStyle(fontSize: 20)),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      side: BorderSide(color: secondary, width: 2),
                      foregroundColor: secondary,
                    ),
                    onPressed: controller.reset,
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
