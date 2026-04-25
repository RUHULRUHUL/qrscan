// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
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
                      QrTypeFormFactory(type: type),
                      20.height,
                      CommonButton(
                        titleText: AppString.generateQRCode,
                        titleColor: AppColor.textBlack,
                        buttonColor: AppColor.primary,
                        borderColor: AppColor.primary,
                        titleSize: 16,
                        buttonHeight: 48,
                        onTap: () {
                          controller.generateQrContent(type);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              24.height,
              // Generated QR Preview
              Obx(() {
                if (controller.generatedQrData.value.isEmpty) {
                  return const SizedBox.shrink();
                }
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      QrImageView(
                        data: controller.generatedQrData.value,
                        version: QrVersions.auto,
                        size: 220,
                        backgroundColor: Colors.white,
                        eyeStyle: const QrEyeStyle(
                          eyeShape: QrEyeShape.square,
                          color: Colors.black,
                        ),
                        dataModuleStyle: const QrDataModuleStyle(
                          dataModuleShape: QrDataModuleShape.square,
                          color: Colors.black,
                        ),
                      ),
                      16.height,
                      Text(
                        controller.generatedQrData.value,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 12,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      16.height,
                      Row(
                        children: [
                          Expanded(
                            child: CommonButton(
                              titleText: 'Copy',
                              titleSize: 14,
                              buttonHeight: 44,
                              prefixIcon: const Icon(Icons.copy,
                                  color: Colors.white, size: 18),
                              onTap: () {
                                // Copy to clipboard
                              },
                            ),
                          ),
                          12.width,
                          Expanded(
                            child: CommonButton(
                              titleText: 'Share',
                              titleSize: 14,
                              buttonHeight: 44,
                              prefixIcon: const Icon(Icons.share,
                                  color: Colors.white, size: 18),
                              onTap: () {
                                // Share QR
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
              100.height,
            ],
          ),
        ),
      ),
    );
  }
}
