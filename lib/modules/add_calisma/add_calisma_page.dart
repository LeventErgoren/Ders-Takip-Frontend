import 'package:ders_app/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'add_calisma_controller.dart';

class AddCalismaPage extends GetView<AddCalismaController> {
  const AddCalismaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final textColor = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;
    final borderColor = Theme.of(context).colorScheme.outlineVariant;
    final focusedBorderColor = isDark ? Colors.tealAccent : Colors.blue;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Çalışma Süresi Ekle"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Tarih seçici
            GestureDetector(
              onTap: () => controller.selectDateWithTheme(context),
              child: Obx(() {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: bgColor,
                    border: Border.all(color: borderColor),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat(
                          'dd MMMM yyyy',
                          'tr_TR',
                        ).format(controller.selectedDate.value),
                        style: TextStyle(color: textColor, fontSize: 16),
                      ),
                      Icon(Icons.calendar_today_outlined, color: textColor),
                    ],
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),

            // Dakika girişi
            TextField(
              controller: controller.minuteController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                labelText: 'Kaç dakika?',
                labelStyle: TextStyle(color: textColor.withOpacity(0.7)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: borderColor),
                  borderRadius: BorderRadius.circular(16),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: focusedBorderColor, width: 2),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              cursorColor: focusedBorderColor,
            ),
            const SizedBox(height: 32),

            // Buton
            Center(
              child: SizedBox(
                width: 220,
                child: ElevatedButton(
                  onPressed: controller.addCalismaSuresi,
                  child: const Text("Çalışma Ekle"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
