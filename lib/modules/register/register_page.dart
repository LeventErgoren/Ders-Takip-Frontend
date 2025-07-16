import 'package:ders_app/modules/register/register_controller.dart';
import 'package:ders_app/modules/routes/app_pages.dart';
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

                  _buildLabel("Ad", theme),
                  _buildTextField(
                    theme,
                    hint: "Adınız",
                    icon: Icons.person_outline,
                    onSaved: (val) => controller.isim.value = val!,
                    validator: controller.nameValidator,
                  ),
                  const SizedBox(height: 18),

                  _buildLabel("Soyad", theme),
                  _buildTextField(
                    theme,
                    hint: "Soyadınız",
                    icon: Icons.person_outline,
                    onSaved: (val) => controller.soyisim.value = val!,
                    validator: controller.lastnameValidator,
                  ),
                  const SizedBox(height: 18),

                  _buildLabel("E-posta", theme),
                  _buildTextField(
                    theme,
                    hint: "ornek@mail.com",
                    icon: Icons.email_outlined,
                    onSaved: (val) => controller.eposta.value = val!,
                    validator: controller.emailValidator,
                    inputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 18),

                  _buildLabel("Kullanıcı Adı", theme),
                  _buildTextField(
                    theme,
                    hint: "kullanici123",
                    icon: Icons.account_circle_outlined,
                    onSaved: (val) => controller.kullaniciAdi.value = val!,
                    validator: controller.usernameValidator,
                  ),
                  const SizedBox(height: 18),

                  _buildLabel("Şifre", theme),
                  _buildTextField(
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

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Zaten hesabın var mı?", style: theme.textTheme.bodyMedium),
                      TextButton(
                        onPressed: () {
                          Get.offAllNamed(AppRoutes.LOGIN);
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: theme.colorScheme.secondary,
                          textStyle: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        child: const Text("Giriş Yap"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text, ThemeData theme) {
    return Text(text, style: theme.textTheme.labelLarge);
  }

  Widget _buildTextField(
    ThemeData theme, {
    required String hint,
    required IconData icon,
    required void Function(String?) onSaved,
    String? Function(String?)? validator,
    bool obscure = false,
    TextInputType inputType = TextInputType.text,
  }) {
    return TextFormField(
      onSaved: onSaved,
      validator: validator,
      obscureText: obscure,
      keyboardType: inputType,
      style: TextStyle(color: theme.colorScheme.onSurface),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: theme.colorScheme.onSurface.withOpacity(0.6),
        ),
        prefixIcon: Icon(icon, color: theme.colorScheme.onSurface),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: theme.colorScheme.primary.withOpacity(0.4),
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: theme.colorScheme.primary.withOpacity(0.4),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        filled: false, // input içi şeffaf olacak
      ),
    );
  }
}
