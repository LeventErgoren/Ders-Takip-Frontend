import 'package:ders_app/modules/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TemaDegistir extends GetView<ProfileController> {
  const TemaDegistir({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return ListTile(
      leading: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
      title: Text(isDarkMode ? "Aydınlık Tema" : "Karanlık Tema"),
      trailing: Switch(
        value: isDarkMode,
        onChanged: (_) {
          controller.changeTheme();
        },
      ),
      onTap: () {
        controller.changeTheme();
      },
    );
  }
}
