import 'package:ders_app/core/base_controller.dart';
import 'package:ders_app/models/calisma_suresi.dart';
import 'package:ders_app/models/calisma_suresi_time.dart';
import 'package:ders_app/repositories/calisma_suresi_repository.dart';
import 'package:ders_app/services/auth_service.dart';
import 'package:ders_app/themes/app_colors.dart';
import 'package:fl_chart/src/chart/bar_chart/bar_chart_data.dart';
import 'package:flutter/material.dart';
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
    final endOfMonth = DateTime(now.year, now.month + 1, 0); // ayın son günü

    final ayVerileri = orijinalVeri
        .where(
          (v) =>
              v.creationDate.isAfter(
                startOfMonth.subtract(const Duration(seconds: 1)),
              ) &&
              v.creationDate.isBefore(endOfMonth.add(const Duration(days: 1))),
        )
        .toList();

    final haftalikVeri = aylikVeriyi4HaftayaGrupla(ayVerileri);

    istenilenVeri.value = haftalikVeri.map((hafta) {
      int toplamDakika = hafta.fold(0, (sum, v) => sum + v.dakika);
      return CalismaSuresi(
        dakika: toplamDakika,
        creationDate: hafta.firstOrNull?.creationDate ?? DateTime.now(),
      );
    }).toList();

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

  void selectedViewChanged(String? value) {
    selectedView.value = value!;
    switch (value) {
      case 'Günlük':
        bugunkuVeriler();
        break;
      case 'Haftalık':
        buHaftaninVerileri();
        break;
      case 'Aylık':
        buAyinVerileri();
        break;
      case 'Yıllık':
        buYilinVerileri();
        break;
    }
  }

  List<DropdownMenuItem<String>> getItems(BuildContext context) {
    return ['Günlük', 'Haftalık', 'Aylık', 'Yıllık']
        .map(
          (view) => DropdownMenuItem(
            value: view,
            child: Text(view, style: Theme.of(context).textTheme.bodyMedium),
          ),
        )
        .toList();
  }

  Widget getBottomTitle(double value, String view, bool isDarkMode) {
    final textStyle = TextStyle(
      color: isDarkMode
          ? AppColors.textPrimaryDark
          : AppColors.textSecondaryLight,
      fontSize: 12,
    );
    if (view == 'Günlük') {
      return Text('Bugün', style: textStyle);
    } else if (view == 'Haftalık') {
      const days = ['P', 'S', 'Ç', 'P', 'C', 'C', 'P'];
      return Text(days[value.toInt()], style: textStyle);
    } else if (view == 'Aylık') {
      return Text('${value.toInt() + 1}. Hafta', style: textStyle);
    } else {
      const months = [
        'O',
        'Ş',
        'M',
        'N',
        'M',
        'H',
        'T',
        'A',
        'E',
        'E',
        'K',
        'A',
      ];
      return Text(months[value.toInt()], style: textStyle);
    }
  }

  double getMaxY(List<BarChartGroupData> barGroups) {
    if (barGroups.isEmpty) return 10;
    final max = barGroups
        .map((e) => e.barRods[0].toY)
        .reduce((a, b) => a > b ? a : b);
    return max <= 0.1 ? 10 : max + (max * 0.1); // %10 marj
  }

  List<List<CalismaSuresi>> aylikVeriyi4HaftayaGrupla(
    List<CalismaSuresi> veriListesi,
  ) {
    List<List<CalismaSuresi>> haftalikVeriler = List.generate(4, (_) => []);

    for (var veri in veriListesi) {
      int gun = veri.creationDate.day;

      if (gun <= 7) {
        haftalikVeriler[0].add(veri);
      } else if (gun <= 14) {
        haftalikVeriler[1].add(veri);
      } else if (gun <= 21) {
        haftalikVeriler[2].add(veri);
      } else {
        haftalikVeriler[3].add(veri); // 22 ve sonrası 4. hafta
      }
    }

    return haftalikVeriler;
  }

  void calismaSuresiHesapla() {
    toplamCalismaSuresi.value = 0;
    for (var c in istenilenVeri.value) {
      toplamCalismaSuresi.value += c.dakika;
    }
  }
}
