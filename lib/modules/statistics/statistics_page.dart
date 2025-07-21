import 'package:ders_app/modules/statistics/statistics_controller.dart';
import 'package:ders_app/modules/statistics/widgets/build_chart.dart';
import 'package:flutter/material.dart';
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
                items: controller.getItems(context),
                onChanged: controller.selectedViewChanged,
              ),
            ),
            const SizedBox(height: 16),
            // Grafik Alanı
            Obx(
              () => controller.isLoading
                  ? Expanded(child: Center(child: CircularProgressIndicator()))
                  : Expanded(child: BuildChart()),
            ),
          ],
        ),
      ),
    );
  }
}
