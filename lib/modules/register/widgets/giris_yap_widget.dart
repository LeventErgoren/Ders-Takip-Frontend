import 'package:ders_app/modules/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GirisYapWidget extends StatelessWidget {
  const GirisYapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
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
    );
  }
}
