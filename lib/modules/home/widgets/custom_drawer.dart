import 'package:ders_app/modules/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ders_app/themes/app_colors.dart';
import 'package:ders_app/modules/home/home_controller.dart';

class CustomDrawer extends GetView<HomeController> {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark
                      ? [AppColors.primaryDark, AppColors.accentDark]
                      : [AppColors.primaryLight, AppColors.accentLight],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.local_fire_department,
                    color: Colors.orangeAccent,
                    size: 40,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Bugünkü Toplam Süre",
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Obx(
                    () => Text(
                      controller.todayTotalTime.value == 0
                          ? "00:00"
                          : controller.calismaSuresiSaatVeDakika(),
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: Icon(
                Icons.bar_chart,
                color: isDark ? Colors.white : theme.colorScheme.primary,
              ),
              title: Text(
                "İstatistikler",
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
              onTap: () {
                Get.toNamed(AppRoutes.STATISTICS);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.access_time,
                color: isDark ? Colors.white : theme.colorScheme.primary,
              ),
              title: Text(
                "Çalışmalarım",
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
              onTap: () {
                Get.toNamed(AppRoutes.TIME);
              },
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                "v1.0",
                style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
