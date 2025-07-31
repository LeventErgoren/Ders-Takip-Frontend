import 'package:ders_app/modules/time/time_controller.dart';
import 'package:get/get.dart';

class TimeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TimeController(),fenix: true);
  }
}
