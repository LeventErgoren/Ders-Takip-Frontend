import 'package:ders_app/models/maintenance.dart';
import 'package:flutter/material.dart';
import 'package:ders_app/themes/app_colors.dart';

class MaintenanceView extends StatelessWidget {
  final Maintenance? maintenance;

  const MaintenanceView({super.key, required this.maintenance});

  @override
  Widget build(BuildContext context) {
    String? reason;
    String? scheduledTime;
    String? startDateRaw;

    if (maintenance != null) {
      reason = maintenance!.reason;
      scheduledTime = maintenance!.scheduledTime; // String: "2 Saat" gibi
      startDateRaw = maintenance!.startDate?.toString(); // ISO string
    }
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final textColor = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;
    final surfaceColor = isDark
        ? AppColors.surfaceDark
        : AppColors.surfaceLight;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: Card(
          color: surfaceColor,
          elevation: 4,
          margin: const EdgeInsets.symmetric(horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.build_rounded,
                  size: 64, // küçültüldü
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  "Uygulama Bakımda",
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 12),
                if (reason != null && reason!.isNotEmpty)
                  Text(
                    reason!,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: textColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                if (startDateRaw != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      "Başlangıç: ${formatRawDate(startDateRaw)}",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: textColor,
                      ),
                    ),
                  ),
                if (scheduledTime != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      "Tahmini Bitiş Süresi: $scheduledTime",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: textColor,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🔧 Tarihi "15:00, 07.08.2025" formatına çevirir
  String formatRawDate(String rawDate) {
    final date = rawDate.substring(0, 10); // YYYY-MM-DD
    final time = rawDate.substring(11, 16); // HH:mm

    final parts = date.split("-");
    final day = parts[2];
    final month = parts[1];
    final year = parts[0];

    return "$time, $day.$month.$year";
  }
}
