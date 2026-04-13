import 'package:get/get.dart';
import 'package:qrscan/feature/view/auth_screens/splash_screen.dart';

class AppRoute {
  static const String splashScreen = "/splashScreen";

  static List<GetPage> pages = [
    GetPage(name: splashScreen, page: () =>const SplashScreen()),

  ];
}