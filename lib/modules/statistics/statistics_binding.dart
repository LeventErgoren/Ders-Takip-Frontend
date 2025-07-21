import 'package:ders_app/modules/statistics/statistics_controller.dart';
import 'package:get/get.dart';

class StatisticsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StatisticsController());
  }
}
