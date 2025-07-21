import 'package:ders_app/modules/statistics/statistics_controller.dart';
import 'package:ders_app/modules/statistics/widgets/build_chart.dart';
import 'package:ders_app/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

class StatisticsPage extends GetView<StatisticsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Çalışma İstatistikleri',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Görünüm Seçici
            Obx(
              () => DropdownButton<String>(
                value: controller.selectedView.value,
                isExpanded: true,
                items: ['Günlük', 'Haftalık', 'Aylık', 'Yıllık']
                    .map(
                      (view) => DropdownMenuItem(
                        value: view,
                        child: Text(
                          view,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  controller.selectedView.value = value!;
                  switch (value) {
                    case 'Günlük':
                      controller.bugunkuVeriler();
                      break;
                    case 'Haftalık':
                      controller.buHaftaninVerileri();
                      break;
                    case 'Aylık':
                      controller.buAyinVerileri();
                      break;
                    case 'Yıllık':
                      controller.buYilinVerileri();
                      break;
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
            // Grafik Alanı
            Expanded(
              child: Obx(() {
                if (controller.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return BuildChart();
              }),
            ),
          ],
        ),
      ),
    );
  }
}
