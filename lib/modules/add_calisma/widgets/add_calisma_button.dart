import 'package:ders_app/modules/add_calisma/add_calisma_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCalismaButton extends GetView<AddCalismaController> {
  const AddCalismaButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 220,
        child: ElevatedButton(
          onPressed: controller.addCalismaSuresi,
          child: const Text("Çalışma Ekle"),
        ),
      ),
    );
  }
}
