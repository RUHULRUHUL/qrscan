import 'package:get/get.dart';
import 'package:qrscan/feature/view/auth_screens/onboarding_screen.dart';
import 'package:qrscan/feature/view/auth_screens/splash_screen.dart';
import 'package:qrscan/feature/view/bottom_nav_screen/bottom_nav_screen.dart';
import 'package:qrscan/feature/view/setting_screen/setting_screen.dart';

class AppRoute {
  static const String splashScreen = "/splashScreen";
  static const String onbordingScreen = "/onbordingScreen";
  static const String bottomNavScreen = "/bottomNavScreen";
  static const String settingScreen = "/settingScreen";

  static List<GetPage> pages = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: onbordingScreen, page: () => const OnboardingScreen()),
    GetPage(name: bottomNavScreen, page: () => const BottomNavScreen()),
    GetPage(name: settingScreen, page: () => const SettingScreen()),
  ];
}
