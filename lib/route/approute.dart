import 'package:get/get.dart';
import 'package:qrscan/feature/view/auth_screens/onboarding_screen.dart';
import 'package:qrscan/feature/view/auth_screens/splash_screen.dart';

class AppRoute {
  static const String splashScreen = "/splashScreen";
  static const String onbordingScreen = "/onbordingScreen";

  static List<GetPage> pages = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: onbordingScreen, page: () => const OnboardingScreen()),
  ];
}
