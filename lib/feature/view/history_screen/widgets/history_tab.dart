// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrscan/core/constant/app_color.dart';
import 'package:qrscan/core/constant/app_string.dart';
import 'package:qrscan/feature/component/common_text.dart';
import 'package:qrscan/feature/view/history_screen/controller/history_controller.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    final HistoryController controler = Get.find<HistoryController>();
    return Container(
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.white.withOpacity(0.15),
          blurRadius: 10,
          spreadRadius: 1,
          offset: const Offset(0, 0),
        ),
      ], color: AppColor.black33, borderRadius: BorderRadius.circular(10)),
      child: Row(
        spacing: 15,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                controler.selectedTab.value = 0;
              },
              child: Obx(() {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: controler.selectedTab.value == 0
                        ? AppColor.primary
                        : null,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const CommonText(
                    text: AppString.scan,
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                );
              }),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                controler.selectedTab.value = 1;
              },
              child: Obx(() {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                      color: controler.selectedTab.value == 1
                          ? AppColor.primary
                          : null,
                      borderRadius: BorderRadius.circular(6)),
                  child: const CommonText(
                    text: AppString.create,
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
