import 'package:flutter/material.dart';
import 'package:qrscan/core/constant/extentions.dart';
import 'package:qrscan/feature/component/common_text.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:const CommonText(text: "Splash Screen").center,
    );
  }
}