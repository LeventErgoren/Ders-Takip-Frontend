import 'package:ders_app/modules/login/login_controller.dart';
import 'package:ders_app/modules/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginForm extends GetView<LoginController> {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
      key: controller.key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hoş Geldin!",
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text("Lütfen hesabına giriş yap.", style: theme.textTheme.bodyMedium),
          const SizedBox(height: 28),

          // Kullanıcı Adı
          Text("Kullanıcı Adı", style: theme.textTheme.labelLarge),
          const SizedBox(height: 6),
          TextFormField(
            onSaved: (newValue) {
              controller.kullaniciAdi.value = newValue!;
            },
            validator: (value) {
              return controller.usernameValidator(value);
            },
            style: TextStyle(color: theme.colorScheme.onSurface),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "Kullanıcı Adı",
              prefixIcon: Icon(
                Icons.person_outline,
                color: theme.colorScheme.onSurface,
              ),
              prefixIconConstraints: const BoxConstraints(
                minWidth: 40,
                minHeight: 40,
              ),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 12,
              ),
            ),
          ),
          const SizedBox(height: 18),

          // Şifre
          Text("Şifre", style: theme.textTheme.labelLarge),
          const SizedBox(height: 6),
          TextFormField(
            onSaved: (newValue) {
              controller.sifre.value = newValue!;
            },
            validator: (value) {
              return controller.sifreValidator(value);
            },
            obscureText: true,
            style: TextStyle(color: theme.colorScheme.onSurface),
            decoration: InputDecoration(
              hintText: "Şifre",
              prefixIcon: Icon(
                Icons.lock_outline,
                color: theme.colorScheme.onSurface,
              ),
              prefixIconConstraints: const BoxConstraints(
                minWidth: 40,
                minHeight: 40,
              ),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 12,
              ),
            ),
          ),

          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                controller.sifreUnuttum();
              },
              style: TextButton.styleFrom(
                foregroundColor: theme.colorScheme.secondary,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              child: const Text("Şifremi unuttum"),
            ),
          ),

          const SizedBox(height: 26),

          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                controller.girisYap();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                textStyle: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              child: const Text("Giriş Yap"),
            ),
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Hesabın yok mu?", style: theme.textTheme.bodyMedium),
              TextButton(
                onPressed: () {
                  Get.offAllNamed(AppRoutes.REGISTER);
                },
                style: TextButton.styleFrom(
                  foregroundColor: theme.colorScheme.secondary,
                  textStyle: const TextStyle(fontWeight: FontWeight.w600),
                ),
                child: const Text("Kayıt Ol"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
