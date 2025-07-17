import 'package:ders_app/modules/register/widgets/build_text_form_field.dart';
import 'package:ders_app/modules/register/register_controller.dart';
import 'package:ders_app/modules/register/widgets/giris_yap_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Form(
              key: controller.key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Kayıt Ol",
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Lütfen bilgilerinizi girin.",
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 28),

                  buildLabel("Ad", theme),
                  buildTextField(
                    theme,
                    hint: "Adınız",
                    icon: Icons.person_outline,
                    onSaved: (val) => controller.isim.value = val!,
                    validator: controller.nameValidator,
                  ),
                  const SizedBox(height: 18),

                  buildLabel("Soyad", theme),
                  buildTextField(
                    theme,
                    hint: "Soyadınız",
                    icon: Icons.person_outline,
                    onSaved: (val) => controller.soyisim.value = val!,
                    validator: controller.lastnameValidator,
                  ),
                  const SizedBox(height: 18),

                  buildLabel("E-posta", theme),
                  buildTextField(
                    theme,
                    hint: "ornek@mail.com",
                    icon: Icons.email_outlined,
                    onSaved: (val) => controller.eposta.value = val!,
                    validator: controller.emailValidator,
                    inputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 18),

                  buildLabel("Kullanıcı Adı", theme),
                  buildTextField(
                    theme,
                    hint: "kullanici123",
                    icon: Icons.account_circle_outlined,
                    onSaved: (val) => controller.kullaniciAdi.value = val!,
                    validator: controller.usernameValidator,
                  ),
                  const SizedBox(height: 18),

                  buildLabel("Şifre", theme),
                  buildTextField(
                    theme,
                    hint: "••••••••",
                    icon: Icons.lock_outline,
                    onSaved: (val) => controller.sifre.value = val!,
                    validator: controller.sifreValidator,
                    obscure: true,
                  ),
                  const SizedBox(height: 28),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () => controller.kayitOl(),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        textStyle: theme.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      child: const Text("Kayıt Ol"),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GirisYapWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
