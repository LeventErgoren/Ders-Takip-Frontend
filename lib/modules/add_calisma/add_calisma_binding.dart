import 'package:ders_app/modules/add_calisma/add_calisma_controller.dart';
import 'package:get/get.dart';

class AddCalismaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddCalismaController());
  }
}
