import 'package:ders_app/core/base_controller.dart';
import 'package:ders_app/models/register_request.dart';
import 'package:ders_app/modules/routes/app_pages.dart';
import 'package:ders_app/services/auth_service.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class RegisterController extends BaseController {
  final key = GlobalKey<FormState>();
  final eposta = "".obs;
  final kullaniciAdi = "".obs;
  final isim = "".obs;
  final soyisim = "".obs;
  final sifre = "".obs;
  final sifreTekrar = "".obs;

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "E-Posta boş olamaz!";
    } else if (!EmailValidator.validate(value)) {
      return "Lütfen uygun bir e-posta giriniz!";
    }
    return null;
  }

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

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "İsim boş olamaz!";
    } else if (value.length < 2) {
      return "İsim en az 2 karakter olmalıdır!";
    }
    return null;
  }

  String? lastnameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Soyisim boş olamaz!";
    } else if (value.length < 2) {
      return "Soyisin en az 2 karakter olmalıdır!";
    }
    return null;
  }

  String? sifreValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Şifre boş olamaz!";
    } else if (value.length < 4) {
      return "Şifre en az 4 karakter olmalıdır.";
    }
    return null;
  }

  String? sifreTekrarValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Şifre boş olamaz!";
    } else if (value.length < 4) {
      return "Şifre en az 4 karakter olmalıdır.";
    } else if (value != sifre.value) {
      return "Şifreler aynı değil!";
    }
    return null;
  }

  void sifreDegisti(String value) {
    sifre.value = value;
  }

  void kayitOl() async {
    if (key.currentState!.validate()) {
      key.currentState!.save();
      AuthService service = Get.find<AuthService>();

      RegisterRequest kullanici = RegisterRequest(
        firstname: isim.value,
        lastname: soyisim.value,
        email: eposta.value,
        username: kullaniciAdi.value,
        password: sifre.value,
      );

      if (await service.register(kullanici)) {
        Get.offAllNamed(AppRoutes.LOGIN);
        showSuccess("Kayıt başarılı!");
      } else {
        if (service.errorMessage.value.contains(eposta.value)) {
          showError("Bu e-posta zaten kullanılıyor!");
        } else if (service.errorMessage.value.contains(kullaniciAdi.value)) {
          showError("Bu kullanıcı adı zaten kullanılıyor!");
        } else {
          showError("Kayıt başarısız!");
        }
      }
    }
  }
}
