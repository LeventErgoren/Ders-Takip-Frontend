import 'package:ders_app/core/base_controller.dart';
import 'package:ders_app/models/calisma_suresi.dart';
import 'package:ders_app/models/calisma_suresi_time.dart';
import 'package:ders_app/repositories/calisma_suresi_repository.dart';
import 'package:ders_app/services/auth_service.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/instance_manager.dart';

class StatisticsController extends BaseController {
  final orijinalVeri = <CalismaSuresi>[].obs;
  final istenilenVeri = <CalismaSuresi>[].obs;
  late AuthService _service;
  late CalismaSuresiRepository _calismaSuresiRepository;
  final toplamCalismaSuresi = 0.obs;
  final selectedView = 'Günlük'.obs;
  
  @override
  void onInit() async {
    super.onInit();
    setLoading(true);

    _service = Get.find<AuthService>();
    _calismaSuresiRepository = Get.find<CalismaSuresiRepository>();
    int id = _service.userId.value;

    orijinalVeri.value = await _calismaSuresiRepository
        .getCalismaSureleriWithTime(CalismaSuresiTime.YEAR, id);

    bugunkuVeriler();
    calismaSuresiHesapla();
    setLoading(false);
  }

  bugunkuVeriler() {
    final now = DateTime.now();
    istenilenVeri.value = orijinalVeri
        .where(
          (v) =>
              v.creationDate.year == now.year &&
              v.creationDate.month == now.month &&
              v.creationDate.day == now.day,
        )
        .toList();
    calismaSuresiHesapla();
  }

  buHaftaninVerileri() {
    final now = DateTime.now();
    final monday = now.subtract(Duration(days: now.weekday - 1));
    final startOfMonday = DateTime(monday.year, monday.month, monday.day);
    istenilenVeri.value = orijinalVeri
        .where(
          (v) => v.creationDate.isAfter(
            startOfMonday.subtract(const Duration(seconds: 1)),
          ),
        )
        .toList();
    calismaSuresiHesapla();
  }

  buAyinVerileri() {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    istenilenVeri.value = orijinalVeri
        .where(
          (v) => v.creationDate.isAfter(
            startOfMonth.subtract(const Duration(seconds: 1)),
          ),
        )
        .toList();
    calismaSuresiHesapla();
  }

  buYilinVerileri() {
    final now = DateTime.now();
    final startOfYear = DateTime(now.year, 1, 1);
    istenilenVeri.value = orijinalVeri
        .where(
          (v) => v.creationDate.isAfter(
            startOfYear.subtract(const Duration(seconds: 1)),
          ),
        )
        .toList();
    calismaSuresiHesapla();
  }

  calismaSuresiHesapla() {
    toplamCalismaSuresi.value = 0;
    for (var c in istenilenVeri.value) {
      toplamCalismaSuresi.value += c.dakika;
    }
  }

}
