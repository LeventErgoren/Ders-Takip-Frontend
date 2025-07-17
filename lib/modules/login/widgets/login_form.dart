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

          Text("Kullanıcı Adı", style: theme.textTheme.labelLarge),
          const SizedBox(height: 6),
          TextFormField(
            initialValue: "leventr13",
            onSaved: (newValue) {
              controller.kullaniciAdi.value = newValue!;
            },
            validator: (value) {
              return controller.usernameValidator(value);
            },

            style: TextStyle(color: theme.colorScheme.onSurface),
            decoration: InputDecoration(
              hintText: "ornek@mail.com",
              hintStyle: TextStyle(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
              prefixIcon: Icon(
                Icons.person_outline,
                color: theme.colorScheme.onSurface,
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: theme.colorScheme.primary.withOpacity(0.4),
                  width: 1,
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: theme.colorScheme.primary.withOpacity(0.4),
                  width: 1,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 12,
              ),
              filled: false,
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 18),

          Text("Şifre", style: theme.textTheme.labelLarge),
          const SizedBox(height: 6),
          TextFormField(
            initialValue: "1234",
            onSaved: (newValue) {
              controller.sifre.value = newValue!;
            },
            validator: (value) {
              return controller.sifreValidator(value);
            },
            obscureText: true,
            style: TextStyle(color: theme.colorScheme.onSurface),
            decoration: InputDecoration(
              hintText: "••••••••",
              hintStyle: TextStyle(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
              prefixIcon: Icon(
                Icons.lock_outline,
                color: theme.colorScheme.onSurface,
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: theme.colorScheme.primary.withOpacity(0.4),
                  width: 1,
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: theme.colorScheme.primary.withOpacity(0.4),
                  width: 1,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 12,
              ),
              filled: false,
            ),
          ),

          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
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
