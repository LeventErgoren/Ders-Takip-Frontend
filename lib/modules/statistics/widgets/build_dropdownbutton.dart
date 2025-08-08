import 'package:ders_app/modules/statistics/statistics_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ders_app/themes/app_colors.dart';

class BuildDropdownbutton extends GetView<StatisticsController> {
  const BuildDropdownbutton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = theme.brightness == Brightness.dark
        ? AppColors.backgroundLight
        : AppColors.primaryLight;

    return Obx(
      () => Container(
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: DropdownButton<String>(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          borderRadius: BorderRadius.circular(12),
          underline: const SizedBox(),
          value: controller.selectedView.value,
          isExpanded: true,
          items: controller.getItems(context),
          onChanged: controller.selectedViewChanged,
        ),
      ),
    );
  }
}
