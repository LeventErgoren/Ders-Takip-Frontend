import 'package:ders_app/modules/add_calisma/add_calisma_controller.dart';
import 'package:ders_app/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectMinute extends GetView<AddCalismaController> {
  const SelectMinute({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final focusedBorderColor = isDark ? Colors.tealAccent : Colors.blue;
    final textColor = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;
    final bgColor = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final borderColor = Theme.of(context).colorScheme.outlineVariant;

    return Form(
      key: controller.globalKey,
      child: TextFormField(
        onSaved: controller.onSaved,
        validator: controller.validate,
        controller: controller.minuteController,
        keyboardType: TextInputType.number,
        style: TextStyle(color: textColor),
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.timer_outlined),
          filled: true,
          fillColor: bgColor,
          labelText: 'Kaç dakika?',
          labelStyle: TextStyle(color: textColor.withValues(alpha: 0.7)),
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
    );
  }
}
