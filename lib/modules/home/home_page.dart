import 'package:ders_app/modules/home/home_controller.dart';
import 'package:ders_app/modules/home/widgets/bottom_navigation_bar_widget.dart';
import 'package:ders_app/modules/home/widgets/floating_action_button_widget.dart';
import 'package:ders_app/modules/main_page/main_page.dart';
import 'package:ders_app/modules/profile/profil_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButtonWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBarWidget(),
      appBar: AppBar(
        title: Text("Uygulama"),
        centerTitle: true,
      ),
      body: Obx(
        () => IndexedStack(
          index: controller.activeIndex.value,
          children: [MainPage(), ProfilePage()],
        ),
      ),
    );
  }
}
