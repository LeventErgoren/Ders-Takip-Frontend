import 'package:ders_app/core/base_controller.dart';
import 'package:ders_app/models/calisma_suresi.dart';
import 'package:ders_app/models/calisma_suresi_time.dart';
import 'package:ders_app/repositories/calisma_suresi_repository.dart';
import 'package:ders_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends BaseController {
  List iconList = [Icons.home_outlined, Icons.person_outlined];
  final activeIndex = 0.obs;
  Rx<int> todayTotalTime = Rx<int>(0);
  late CalismaSuresiRepository _service;
  late AuthService _authService;
  Rx<List<CalismaSuresi>?> todayCalismaSureleri = Rx<List<CalismaSuresi>?>(
    null,
  );

  @override
  void onInit() async {
    super.onInit();

    _authService = Get.find<AuthService>();
    _service = Get.find<CalismaSuresiRepository>();

    await calismaSuresiGuncelle();
  }

  Future<void> calismaSuresiGuncelle() async {
    setLoading(true);
    todayCalismaSureleri.value = await _service.getCalismaSureleriWithTime(
      CalismaSuresiTime.TODAY,
      _authService.userId.value,
    );
    _todayCalismaSuresiTopla();
    setLoading(false);
  }

  void _todayCalismaSuresiTopla() {
    if (todayCalismaSureleri.value == null) {
      return;
    }
    todayTotalTime.value = 0;
    for (var c in todayCalismaSureleri.value!) {
      todayTotalTime.value = todayTotalTime.value + c.dakika;
    }
  }

  String calismaSuresiSaatVeDakika() {
    int saat = todayTotalTime.value ~/ 60;
    int dakika = todayTotalTime.value % 60;

    return "$saat Saat $dakika Dakika";
  }
}
