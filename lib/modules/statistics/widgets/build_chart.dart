import 'package:ders_app/modules/statistics/statistics_controller.dart';
import 'package:ders_app/modules/statistics/widgets/bar_groups.dart';
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
      final barGroups = getBarGroups(context, controller);
      final maxY = controller.getMaxY(barGroups);
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
                  return controller.getBottomTitle(value, view, isDarkMode);
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
}
