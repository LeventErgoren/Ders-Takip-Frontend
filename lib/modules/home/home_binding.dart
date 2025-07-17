import 'package:ders_app/modules/home/home_controller.dart';
import 'package:ders_app/modules/main_page/main_page_controller.dart';
import 'package:ders_app/modules/profile/profile_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.lazyPut(() => MainPageController());
    Get.lazyPut(() => ProfileController());
  }
}
