import 'package:ders_app/modules/add_calisma/add_calisma_binding.dart';
import 'package:ders_app/modules/add_calisma/add_calisma_page.dart';
import 'package:ders_app/modules/home/home_binding.dart';
import 'package:ders_app/modules/home/home_page.dart';
import 'package:ders_app/modules/login/login_binding.dart';
import 'package:ders_app/modules/login/login_page.dart';
import 'package:ders_app/modules/register/register_binding.dart';
import 'package:ders_app/modules/register/register_page.dart';
import 'package:ders_app/modules/splash/splash_binding.dart';
import 'package:ders_app/modules/splash/splash_page.dart';
import 'package:ders_app/modules/statistics/statistics_binding.dart';
import 'package:ders_app/modules/statistics/statistics_page.dart';
import 'package:ders_app/modules/time/time_binding.dart';
import 'package:ders_app/modules/time/time_page.dart';
import 'package:get/get_navigation/get_navigation.dart';

abstract class AppRoutes {
  static const INITIAL = SPLASH;
  static const SPLASH = "/splash";
  static const LOGIN = "/login";
  static const REGISTER = "/register";
  static const HOME = "/home";
  static const STATISTICS = "/statistics";
  static const TIME = "/time";
  static const ADD_WORK = "/add-work";
}

class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.REGISTER,
      page: () => RegisterPage(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.STATISTICS,
      page: () => StatisticsPage(),
      binding: StatisticsBinding(),
    ),
    GetPage(
      name: AppRoutes.TIME,
      page: () => TimePage(),
      binding: TimeBinding(),
    ),
    GetPage(
      name: AppRoutes.ADD_WORK,
      page: () => AddCalismaPage(),
      binding: AddCalismaBinding(),
    ),
  ];
}
