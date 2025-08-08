import 'package:ders_app/core/base_controller.dart';
import 'package:ders_app/models/user.dart';
import 'package:ders_app/services/auth_service.dart';
import 'package:ders_app/services/theme_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProfileController extends BaseController {
  late AuthService _service;
  late ThemeService _themeService;
  Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() async {
    super.onInit();
    _themeService = Get.find<ThemeService>();
    setLoading(true);
    _service = Get.find<AuthService>();
    user.value = await _service.getProfile();
    setLoading(false);
  }

  String getDate() {
    return DateFormat('d/MM/y').format(user.value!.creationDate);
  }

  void changeTheme() {
    _themeService.toogleTheme();
  }
}
