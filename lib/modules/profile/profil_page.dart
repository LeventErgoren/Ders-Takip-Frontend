import 'package:ders_app/modules/profile/profile_controller.dart';
import 'package:ders_app/modules/profile/widgets/calismalarim.dart';
import 'package:ders_app/modules/profile/widgets/cikis_yap.dart';
import 'package:ders_app/modules/profile/widgets/eposta_ve_kayit_tarihi.dart';
import 'package:ders_app/modules/profile/widgets/istatistikler.dart';
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
      return isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ProfilKart(),

                    const SizedBox(height: 24),

                    EpostaVeKayitTarihi(),

                    const SizedBox(height: 32),

                    const IstatistiklerButonu(),

                    const Divider(height: 32),

                    const CalismalarimButonu(),

                    const Divider(height: 32),

                    TemaDegistir(),

                    const Divider(height: 32),

                    CikisYap(),
                  ],
                ),
              ),
            );
    });
  }
}
