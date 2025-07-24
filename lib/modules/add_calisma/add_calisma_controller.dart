import 'package:ders_app/core/base_controller.dart';
import 'package:ders_app/repositories/calisma_suresi_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddCalismaController extends BaseController {
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final TextEditingController minuteController = TextEditingController();

  late final CalismaSuresiRepository _repo;

  @override
  void onInit() {
    super.onInit();
    _repo = Get.find<CalismaSuresiRepository>();
  }

  Future<void> selectDate() async {
    final picked = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate.value,
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now(),
      locale: const Locale("tr", "TR"),
    );
    if (picked != null) {
      selectedDate.value = picked;
    }
  }

  Future<void> addCalismaSuresi() async {
    final input = minuteController.text.trim();
    if (input.isEmpty || int.tryParse(input) == null) {
      Get.snackbar("Hata", "Lütfen geçerli bir dakika girin");
      return;
    }

    final dakika = int.parse(input);
    final tarih = selectedDate.value;

    // Veritabanına kaydetme

    Get.back(); // Sayfadan çık
    Get.snackbar(
      "Başarılı",
      "${DateFormat('dd MMMM yyyy', 'tr_TR').format(tarih)} tarihine $dakika dakika eklendi.",
    );
  }

  Future<void> selectDateWithTheme(BuildContext context) async {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: isDark
                ? const ColorScheme.dark(
                    primary: Colors.tealAccent,
                    surface: Colors.grey,
                    onSurface: Colors.white,
                  )
                : const ColorScheme.light(
                    primary: Colors.blue,
                    surface: Colors.white,
                    onSurface: Colors.black,
                  ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
    }
  }
}
