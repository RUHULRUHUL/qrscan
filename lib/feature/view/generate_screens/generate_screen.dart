// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:qrscan/core/constant/app_color.dart';
import 'package:qrscan/core/constant/app_string.dart';
import 'package:qrscan/feature/component/common_text.dart';
import 'package:qrscan/feature/view/generate_screens/controller/qr_generate_controller.dart';
import 'package:qrscan/feature/view/generate_screens/widgets/qr_builder_card.dart';

class GenerateScreen extends StatelessWidget {
  const GenerateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final QrGenerateController controller = Get.find<QrGenerateController>();
    return Scaffold(
      backgroundColor: AppColor.black33,
      appBar: AppBar(
        automaticallyImplyLeading: false,
      backgroundColor: AppColor.black33,
        title:const CommonText(
          text: AppString.generateQR,
          fontSize: 27,
          fontWeight: FontWeight.w400,
          color: Color(0xFFD9D9D9),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
        child: GridView.builder(
          itemCount: controller.qrItem.length,
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 25,
            crossAxisSpacing: 10,
            childAspectRatio: 1, // square item
          ),
          itemBuilder: (context, index) {
            var item = controller.qrItem[index];
            return QrBuilderCard(title: item["title"], icon: item["icon"]);
          },
        ),
      ),
    );
  }
}
