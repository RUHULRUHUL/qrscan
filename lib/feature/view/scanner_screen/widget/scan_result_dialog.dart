// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrscan/core/constant/app_string.dart';
import 'package:qrscan/core/constant/extentions.dart';
import 'package:qrscan/feature/component/common_button.dart';
import 'package:qrscan/feature/component/common_text.dart';

class ScanResultDialog {
  static void show({
    required String code,
    required VoidCallback onScanAgain,
  }) {
    Get.dialog(
      Dialog(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.blueAccent.withOpacity(0.25),
                blurRadius: 25,
                spreadRadius: 2,
                offset: const Offset(0, 0),
              ),
              BoxShadow(
                color: Colors.blue.withOpacity(0.12),
                blurRadius: 40,
                spreadRadius: 6,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Success Icon
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDB623).withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: Color(0xFFFFFFFF),
                    size: 50,
                  ),
                ),

                10.height,

                const CommonText(
                  text: AppString.scannSuccessfull,
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),

                10.height,
                Container(
                  padding: const EdgeInsets.all(12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Flexible(
                        child: CommonText(
                          text: code,
                          color: Colors.white70,
                          fontSize: 14,
                        ).start,
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.copy,
                            color: Colors.white,
                          ))
                    ],
                  ),
                ),
                20.height,
                Row(
                  spacing: 10,
                  children: [
                    Expanded(
                        child: CommonButton(
                      onTap: () {},
                      prefixIcon: const Icon(
                        Icons.share,
                        color: Colors.white,
                      ),
                      titleText: AppString.share,
                      titleSize: 14,
                    )),
                    Expanded(
                        child: CommonButton(
                      onTap: () {},
                      suffixIcon: const Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.white,
                      ),
                      titleText: AppString.visit,
                      titleSize: 14,
                    )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
