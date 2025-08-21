import 'package:ders_app/core/base_controller.dart';
import 'package:ders_app/modules/home/home_controller.dart';
import 'package:ders_app/repositories/calisma_suresi_repository.dart';
import 'package:ders_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddCalismaController extends BaseController {
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final TextEditingController minuteController = TextEditingController();
  final globalKey = GlobalKey<FormState>();
  int eklenecekDakika = 0;
  late CalismaSuresiRepository _service;
  late AuthService _authService;
  late HomeController _homeController;

  Future<void> addCalismaSuresi() async {
    validateAndSave();

    DateTime date = selectedDate.value;
    int minute = eklenecekDakika;
    int id = _authService.userId.value;

    bool isSaved = await _service.addCalismaSuresiWithTime(id, minute, date);

    if (isSaved) {
      await _homeController.calismaSuresiGuncelle();
      Get.back();
      showSuccess("Kayıt Başarılı");
      return;
    }
    showError("Kayıt Başarısız");
  }

  Future<void> selectDateWithTheme(BuildContext context) async {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final DateTime? picked = await showDatePicker(
      locale: const Locale('tr', "TR"),
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now(),
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

  String formatDate() {
    return DateFormat('dd MMMM yyyy', 'tr_TR').format(selectedDate.value);
  }

  void onSaved(String? newValue) {
    eklenecekDakika = int.parse(newValue!);
  }

  String? validate(String? value) {
    if (value == null) {
      return "Dakika boş olamaz";
    }
    if (value.isEmpty) {
      return "Dakika boş olamaz";
    }

    try {
      int dakika = int.parse(value);

      if (dakika < 1) {
        return "1 Dakika altında kayıt yapılamaz";
      }

      if (dakika > 1000) {
        return "1000 Dakikadan fazla kayıt yapılamaz";
      }

      return null;
    } catch (e) {
      return "Girdiğiniz şey sayı türünde değildir";
    }
  }

  void validateAndSave() {
    if (!globalKey.currentState!.validate()) {
      return;
    }
    globalKey.currentState!.save();
  }

  @override
  void onInit() {
    super.onInit();
    _service = Get.find<CalismaSuresiRepository>();
    _authService = Get.find<AuthService>();
    _homeController = Get.find<HomeController>();
  }
}
