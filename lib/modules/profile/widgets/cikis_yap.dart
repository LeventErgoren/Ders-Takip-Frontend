import 'package:ders_app/modules/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CikisYap extends StatelessWidget {
  const CikisYap({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.logout),
      title: const Text("Çıkış Yap"),
      onTap: () {
        Get.offAllNamed(AppRoutes.LOGIN);
      },
    );
  }
}
