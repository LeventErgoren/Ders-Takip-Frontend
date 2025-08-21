import 'package:ders_app/themes/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

List<BarChartGroupData> getBarGroups(BuildContext context, dynamic controller) {
  final view = controller.selectedView.value;
  final data = controller.istenilenVeri;
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  final activeGradient = LinearGradient(
    colors: [
      isDarkMode ? AppColors.accentDark : AppColors.accentLight,
      isDarkMode
          ? AppColors.accentDark.withOpacity(0.5)
          : AppColors.accentLight.withOpacity(0.5),
      Colors.white.withOpacity(isDarkMode ? 0.3 : 0.9),
    ],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  final zeroGradient = LinearGradient(
    colors: [
      isDarkMode
          ? AppColors.textSecondaryDark.withOpacity(0.6)
          : AppColors.textSecondaryLight.withOpacity(0.6),
      isDarkMode
          ? AppColors.textSecondaryDark.withOpacity(0.4)
          : AppColors.textSecondaryLight.withOpacity(0.4),
    ],
    stops: [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  if (view == 'Günlük') {
    final totalMinutes = controller.toplamCalismaSuresi.value;
    return [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
            toY: totalMinutes == 0 ? 0.1 : totalMinutes.toDouble(),
            gradient: totalMinutes == 0 ? zeroGradient : activeGradient,
            width: 20,
            borderRadius: BorderRadius.circular(4),
            backDrawRodData: totalMinutes == 0
                ? BackgroundBarChartRodData(
                    show: true,
                    toY: 0.1,
                    color: isDarkMode
                        ? AppColors.textSecondaryDark.withOpacity(0.5)
                        : AppColors.textSecondaryLight.withOpacity(0.5),
                  )
                : null,
          ),
        ],
      ),
    ];
  } else if (view == 'Haftalık') {
    Map<int, double> groupedData = {0: 0, 1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0};

    final now = DateTime.now();
    final daysFromMonday = now.weekday - 1;
    final monday = now.subtract(Duration(days: daysFromMonday));

    for (var item in data) {
      final date = item.creationDate;
      final dayIndex = date
          .difference(DateTime(monday.year, monday.month, monday.day))
          .inDays;
      if (dayIndex >= 0 && dayIndex < 7) {
        groupedData[dayIndex] = (groupedData[dayIndex] ?? 0) + item.dakika;
      }
    }

    return groupedData.entries.map((e) {
      return BarChartGroupData(
        x: e.key,
        barRods: [
          BarChartRodData(
            toY: e.value == 0 ? 0.1 : e.value,
            gradient: e.value == 0 ? zeroGradient : activeGradient,
            width: 12,
            borderRadius: BorderRadius.circular(4),
            backDrawRodData: e.value == 0
                ? BackgroundBarChartRodData(
                    show: true,
                    toY: 0.1,
                    color: isDarkMode
                        ? AppColors.textSecondaryDark.withOpacity(0.5)
                        : AppColors.textSecondaryLight.withOpacity(0.5),
                  )
                : null,
          ),
        ],
      );
    }).toList();
  } else if (view == 'Aylık') {
    Map<int, double> groupedData = {0: 0, 1: 0, 2: 0, 3: 0};
    for (var item in data) {
      final date = item.creationDate;
      final weekIndex = ((date.day - 1) / 7).floor();
      if (weekIndex < 4) {
        groupedData[weekIndex] = (groupedData[weekIndex] ?? 0) + item.dakika;
      }
    }
    return groupedData.entries.map((e) {
      return BarChartGroupData(
        x: e.key,
        barRods: [
          BarChartRodData(
            toY: e.value == 0 ? 0.1 : e.value,
            gradient: e.value == 0 ? zeroGradient : activeGradient,
            width: 16,
            borderRadius: BorderRadius.circular(4),
            backDrawRodData: e.value == 0
                ? BackgroundBarChartRodData(
                    show: true,
                    toY: 0.1,
                    color: isDarkMode
                        ? AppColors.textSecondaryDark.withOpacity(0.5)
                        : AppColors.textSecondaryLight.withOpacity(0.5),
                  )
                : null,
          ),
        ],
      );
    }).toList();
  } else {
    Map<int, double> groupedData = {
      0: 0,
      1: 0,
      2: 0,
      3: 0,
      4: 0,
      5: 0,
      6: 0,
      7: 0,
      8: 0,
      9: 0,
      10: 0,
      11: 0,
    };
    for (var item in data) {
      final monthIndex = item.creationDate.month - 1;
      groupedData[monthIndex] = (groupedData[monthIndex] ?? 0) + item.dakika;
    }
    return groupedData.entries.map((e) {
      return BarChartGroupData(
        x: e.key,
        barRods: [
          BarChartRodData(
            toY: e.value == 0 ? 0.1 : e.value,
            gradient: e.value == 0 ? zeroGradient : activeGradient,
            width: 16,
            borderRadius: BorderRadius.circular(4),
            backDrawRodData: e.value == 0
                ? BackgroundBarChartRodData(
                    show: true,
                    toY: 0.1,
                    color: isDarkMode
                        ? AppColors.textSecondaryDark.withOpacity(0.5)
                        : AppColors.textSecondaryLight.withOpacity(0.5),
                  )
                : null,
          ),
        ],
      );
    }).toList();
  }
}
