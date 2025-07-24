import 'package:ders_app/modules/time/time_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildPagination extends GetView<TimeController> {
  const BuildPagination({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Obx(() {
      final current = controller.currentPage.value;
      final totalPages = (controller.maxPage.value / controller.pageSize.value)
          .ceil();
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: current > 0
                  ? () {
                      controller.currentPage.value--;
                      controller.getPaginatedList();
                    }
                  : null,
            ),
            Text(
              'Sayfa ${current + 1} / $totalPages',
              style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: current < totalPages - 1
                  ? () {
                      controller.currentPage.value++;
                      controller.getPaginatedList();
                    }
                  : null,
            ),
          ],
        ),
      );
    });
  }
}
