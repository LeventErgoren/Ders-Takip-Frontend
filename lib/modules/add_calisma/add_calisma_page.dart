import 'package:ders_app/modules/add_calisma/widgets/add_calisma_button.dart';
import 'package:ders_app/modules/add_calisma/widgets/select_date.dart';
import 'package:ders_app/modules/add_calisma/widgets/select_minute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_calisma_controller.dart';

class AddCalismaPage extends GetView<AddCalismaController> {
  const AddCalismaPage({super.key});

  @override
  Widget build(BuildContext context) {
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
            SelectDate(),
            const SizedBox(height: 24),

            SelectMinute(),
            const SizedBox(height: 32),

            AddCalismaButton(),
          ],
        ),
      ),
    );
  }
}
