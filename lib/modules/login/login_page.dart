import 'package:ders_app/modules/login/login_controller.dart';
import 'package:ders_app/modules/login/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: LoginForm(),
          ),
        ),
      ),
    );
  }
}
