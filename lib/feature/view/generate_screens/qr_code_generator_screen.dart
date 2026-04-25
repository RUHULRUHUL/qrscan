// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qrscan/core/constant/app_color.dart';
import 'package:qrscan/core/constant/app_string.dart';
import 'package:qrscan/core/constant/extentions.dart';
import 'package:qrscan/feature/component/common_appbar.dart';
import 'package:qrscan/feature/component/common_button.dart';
import 'package:qrscan/feature/view/generate_screens/controller/qr_generate_controller.dart';
import 'package:qrscan/feature/view/generate_screens/widgets/qr_type_forms.dart';

class QrCodeGeneratorScreen extends StatelessWidget {
  const QrCodeGeneratorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>?;
    final title = args?["title"] ?? "";
    final icon = args?["icon"] ?? "";
    final type = args?["type"] ?? "";

    final QrGenerateController controller = Get.find<QrGenerateController>();

    return Scaffold(
      backgroundColor: AppColor.black33,
      appBar: CommonAppBar(title: title),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            children: [
              // Main card with yellow top & bottom borders
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF3A3A3A),
                  borderRadius: BorderRadius.circular(16),
                  border: const Border(
                    top: BorderSide(color: AppColor.primary, width: 2),
                    bottom: BorderSide(color: AppColor.primary, width: 2),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Type icon
                      if (icon.isNotEmpty)
                        SvgPicture.asset(
                          icon,
                          height: 55,
                          width: 55,
                          colorFilter: const ColorFilter.mode(
                            AppColor.primary,
                            BlendMode.srcIn,
                          ),
                        ),
                      16.height,
                      // Dynamic form based on type
                      QrTypeFormFactory(type: type),
                      20.height,
                      // Generate button
                      CommonButton(
                        titleText: AppString.generateQRCode,
                        titleColor: AppColor.textBlack,
                        buttonColor: AppColor.primary,
                        borderColor: AppColor.primary,
                        titleSize: 16,
                        buttonHeight: 48,
                        onTap: () {
                          final data = controller.generateQrContent(type);
                          debugPrint("Generated QR Data: $data");
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
