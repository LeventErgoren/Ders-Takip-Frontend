import 'package:ders_app/modules/profile/profile_controller.dart';
import 'package:ders_app/modules/profile/widgets/eposta_ve_kayit_tarihi.dart';
import 'package:ders_app/modules/profile/widgets/profil_kart.dart';
import 'package:ders_app/modules/profile/widgets/tema_degistir.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isLoading = controller.isLoading;
      final user = controller.user.value;
      return isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Profil Kartı: avatar + isim
                  ProfilKart(),

                  const SizedBox(height: 24),

                  // E-posta ve Kayıt Tarihi (karanlık tema seçeneğinin üstünde)
                  EpostaVeKayitTarihi(),

                  const SizedBox(height: 32),

                  // Tema Değiştir
                  TemaDegistir(),

                  const Divider(height: 32),

                  // Çıkış Yap
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text("Çıkış Yap"),
                    onTap: () {
                      Get.offAllNamed('/login');
                    },
                  ),
                ],
              ),
            );
    });
  }
}
