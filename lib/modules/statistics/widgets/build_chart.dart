import 'package:ders_app/modules/statistics/statistics_controller.dart';
import 'package:ders_app/themes/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildChart extends GetView<StatisticsController> {
  const BuildChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final view = controller.selectedView.value;
      final barGroups = _getBarGroups(context);
      final maxY = _getMaxY(barGroups);
      final isDarkMode = Theme.of(context).brightness == Brightness.dark;

      return BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (group) =>
                  isDarkMode ? AppColors.surfaceDark : AppColors.surfaceLight,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  '${rod.toY.toInt()} dk',
                  TextStyle(
                    color: isDarkMode
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimaryLight,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  if (value == 0 || value == maxY) return const SizedBox();
                  return Text(
                    value.toInt().toString(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isDarkMode
                          ? AppColors.textPrimaryDark
                          : AppColors.textSecondaryLight,
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (value, meta) {
                  return _getBottomTitle(value, view, isDarkMode);
                },
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false), // Kenarlık kaldırıldı
          gridData: FlGridData(show: false), // Grid kaldırıldı
          barGroups: barGroups,
          minY: 0,
          maxY: maxY,
        ),
      );
    });
  }

  List<BarChartGroupData> _getBarGroups(BuildContext context) {
    final view = controller.selectedView.value;
    final data = controller.istenilenVeri;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final activeGradient = LinearGradient(
      colors: [
        isDarkMode ? AppColors.accentDark : AppColors.accentLight,
        isDarkMode
            ? AppColors.accentDark.withOpacity(0.5)
            : AppColors.accentLight.withOpacity(0.5),
        Colors.white.withOpacity(isDarkMode ? 0.3 : 0.9), // Belirgin parlama
      ],
      stops: [0.0, 0.5, 1.0], // Gradyan geçiş noktaları
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
              toY: totalMinutes == 0
                  ? 0.1
                  : totalMinutes.toDouble(), // Sıfır için küçük yükseklik
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
      Map<int, double> groupedData = {
        0: 0,
        1: 0,
        2: 0,
        3: 0,
        4: 0,
        5: 0,
        6: 0,
      }; // Tüm günler için sıfır başlat
      final now = DateTime.now();
      final monday = now.subtract(Duration(days: now.weekday - 1));
      for (var item in data) {
        final date = item.creationDate;
        final dayIndex = date.difference(monday).inDays;
        if (dayIndex >= 0 && dayIndex < 7) {
          groupedData[dayIndex] = (groupedData[dayIndex] ?? 0) + item.dakika;
        }
      }
      return groupedData.entries.map((e) {
        return BarChartGroupData(
          x: e.key,
          barRods: [
            BarChartRodData(
              toY: e.value == 0 ? 0.1 : e.value, // Sıfır için küçük yükseklik
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
      Map<int, double> groupedData = {
        0: 0,
        1: 0,
        2: 0,
        3: 0,
      }; // Tüm haftalar için sıfır başlat
      final now = DateTime.now();
      final startOfMonth = DateTime(now.year, now.month, 1);
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
              toY: e.value == 0 ? 0.1 : e.value, // Sıfır için küçük yükseklik
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
      }; // Tüm aylar için sıfır başlat
      for (var item in data) {
        final monthIndex = item.creationDate.month - 1;
        groupedData[monthIndex] = (groupedData[monthIndex] ?? 0) + item.dakika;
      }
      return groupedData.entries.map((e) {
        return BarChartGroupData(
          x: e.key,
          barRods: [
            BarChartRodData(
              toY: e.value == 0 ? 0.1 : e.value, // Sıfır için küçük yükseklik
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

  Widget _getBottomTitle(double value, String view, bool isDarkMode) {
    final textStyle = TextStyle(
      color: isDarkMode
          ? AppColors.textPrimaryDark
          : AppColors.textSecondaryLight,
      fontSize: 12,
    );
    if (view == 'Günlük') {
      return Text('Bugün', style: textStyle);
    } else if (view == 'Haftalık') {
      const days = ['P', 'S', 'Ç', 'P', 'C', 'C', 'P'];
      return Text(days[value.toInt()], style: textStyle);
    } else if (view == 'Aylık') {
      return Text('${value.toInt() + 1}. Hafta', style: textStyle);
    } else {
      const months = [
        'O',
        'Ş',
        'M',
        'N',
        'M',
        'H',
        'T',
        'A',
        'E',
        'E',
        'K',
        'A',
      ];
      return Text(months[value.toInt()], style: textStyle);
    }
  }

  double _getMaxY(List<BarChartGroupData> barGroups) {
    if (barGroups.isEmpty) return 10;
    final max = barGroups
        .map((e) => e.barRods[0].toY)
        .reduce((a, b) => a > b ? a : b);
    return max <= 0.1
        ? 10
        : max + (max * 0.1); // %10 marj ekle, sıfır veya küçükse varsayılan 10
  }
}
