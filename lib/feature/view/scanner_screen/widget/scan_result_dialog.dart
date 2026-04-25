import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qrscan/core/constant/app_string.dart';
import 'package:qrscan/core/constant/extentions.dart';
import 'package:qrscan/feature/component/common_button.dart';
import 'package:qrscan/feature/component/common_text.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ScanResultDialog {
  static void show({
    required String code,
    required VoidCallback onScanAgain,
  }) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.blueAccent.withValues(alpha: 0.25),
                blurRadius: 25,
                spreadRadius: 2,
                offset: const Offset(0, 0),
              ),
              BoxShadow(
                color: Colors.blue.withValues(alpha: 0.12),
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
                    color: const Color(0xFFFDB623).withValues(alpha: 0.2),
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
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: code));
                          Get.snackbar('Copied', 'QR code copied to clipboard',
                              backgroundColor: Colors.green,
                              colorText: Colors.white);
                        },
                        icon: const Icon(
                          Icons.copy,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                20.height,
                Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      child: CommonButton(
                        onTap: () {
                          Share.share(code);
                        },
                        prefixIcon: const Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                        titleText: AppString.share,
                        titleSize: 14,
                      ),
                    ),
                    Expanded(
                      child: CommonButton(
                        onTap: () async {
                          final Uri? uri = _getLaunchUri(code);
                          if (uri != null) {
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(uri,
                                  mode: LaunchMode.externalApplication);
                            } else {
                              Get.snackbar('Error',
                                  'Could not open this link');
                            }
                          } else {
                            Get.snackbar('Info',
                                'This content cannot be visited directly');
                          }
                        },
                        suffixIcon: const Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.white,
                        ),
                        titleText: AppString.visit,
                        titleSize: 14,
                      ),
                    ),
                  ],
                ),
                10.height,
                CommonButton(
                  onTap: () {
                    Get.back();
                    onScanAgain();
                  },
                  titleText: 'Scan Again',
                  titleSize: 14,
                  buttonColor: Colors.transparent,
                  borderColor: const Color(0xFF555555),
                  titleColor: Colors.white70,
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static Uri? _getLaunchUri(String code) {
    final lower = code.toLowerCase().trim();
    try {
      if (lower.startsWith('http')) {
        return Uri.parse(code);
      }
      if (lower.startsWith('mailto:')) {
        return Uri.parse(code);
      }
      if (lower.startsWith('tel:')) {
        return Uri.parse(code);
      }
      if (lower.startsWith('https://wa.me/') ||
          lower.startsWith('http://wa.me/')) {
        return Uri.parse(code);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
