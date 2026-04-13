import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qrscan/core/dependency/dependency_injection.dart';
import 'package:qrscan/route/approute.dart';

void main() {
  _action();
  runApp(const MyApp());
}

_action() {
  WidgetsFlutterBinding.ensureInitialized();
  var di = DependencyInjection();
  di.dependencies();

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: ScreenUtilInit(
        designSize: const Size(640, 960),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Mino_Ride',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          initialRoute: AppRoute.splashScreen,
          getPages: AppRoute.pages,
        ),
      ),
    );
  }
}
