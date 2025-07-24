import 'package:ders_app/modules/time/time_controller.dart';
import 'package:ders_app/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildSortChips extends GetView<TimeController> {
  const BuildSortChips({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Obx(() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ChoiceChip(
              label: const Text('Artan'),
              selected: controller.sort.value == 'asc',
              onSelected: controller.makeAsc,
              selectedColor: AppColors.accentLight,
              backgroundColor: isDark
                  ? Colors.grey[800]
                  : AppColors.surfaceLight,
              labelStyle: TextStyle(
                color: controller.sort.value == 'asc'
                    ? Colors.white
                    : Theme.of(context).textTheme.bodyMedium?.color,
              ),
              side: BorderSide(
                color: controller.sort.value == 'asc'
                    ? Colors.transparent
                    : Colors.transparent,
              ),
            ),
            const SizedBox(width: 12),
            ChoiceChip(
              label: const Text('Azalan'),
              selected: controller.sort.value == 'desc',
              onSelected: controller.makeDesc,
              selectedColor: AppColors.accentLight,
              backgroundColor: isDark
                  ? Colors.grey[800]
                  : AppColors.surfaceLight,
              labelStyle: TextStyle(
                color: controller.sort.value == 'desc'
                    ? Colors.white
                    : Theme.of(context).textTheme.bodyMedium?.color,
              ),
              side: BorderSide(color: Colors.transparent),
            ),
          ],
        );
      }),
    );
  }
}
