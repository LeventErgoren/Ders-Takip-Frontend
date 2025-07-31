import 'package:ders_app/modules/routes/app_pages.dart';
import 'package:ders_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CikisYap extends GetView<AuthService> {
  const CikisYap({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.logout),
      title: const Text("Çıkış Yap"),
      onTap: () async {
        await controller.signOut();
      },
    );
  }
}
