import 'package:ders_app/core/base_controller.dart';
import 'package:ders_app/models/login_request.dart';
import 'package:ders_app/modules/routes/app_pages.dart';
import 'package:ders_app/services/api_service.dart';
import 'package:ders_app/services/auth_service.dart';
import 'package:ders_app/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends BaseController {
  final kullaniciAdi = "".obs;
  final sifre = "".obs;
  final key = GlobalKey<FormState>();
  final isPasswordHidden = false.obs;

  String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Lütfen kullanıcı adınızı giriniz!";
    } else if (value.length < 3) {
      return "Kullanıcı adı en az 3 karakterden oluşmalıdır!";
    } else if (value.length > 30) {
      return "Kullanıcı adı en fazla 30 karakter olabilir!";
    } else if (value.contains(" ")) {
      return "Lütfen uygun karakterler giriniz";
    }
    return null;
  }

  String? sifreValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Lütfen şifrenizi giriniz!";
    } else if (value.length < 4) {
      return "Şifre en az 4 karakterden oluşmalıdır!";
    }
    return null;
  }

  void girisYap() async {
    if (key.currentState!.validate()) {
      key.currentState!.save();

      AuthService service = Get.find<AuthService>();
      LoginRequest user = LoginRequest(
        username: kullaniciAdi.value,
        password: sifre.value,
      );

      if (await service.login(user)) {
        Get.offAllNamed(AppRoutes.HOME);
        Get.find<ApiService>().inApp = true;
        showSuccess("Giriş başarılı!");
      } else {
        showError(service.errorMessage.value);
      }
    }
  }

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void sifreUnuttum() {
    showError("Eklenecek");
  }
}
