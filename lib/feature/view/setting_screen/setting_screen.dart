import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrscan/core/constant/app_color.dart';
import 'package:qrscan/core/constant/app_icon.dart';
import 'package:qrscan/core/constant/app_string.dart';
import 'package:qrscan/core/constant/extentions.dart';
import 'package:qrscan/feature/component/common_text.dart';
import 'package:qrscan/feature/view/setting_screen/widget/setting_item.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _vibrateEnabled = false;
  bool _beepEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(225, 92, 92, 104),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            50.height,
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5)),
                child: const Icon(
                  Icons.keyboard_arrow_left,
                  color: Color(0xFFFDB623),
                  size: 30,
                ),
              ),
            ),
            30.height,

            //================================================setti  ngs block
            const CommonText(
              text: AppString.settings,
              fontSize: 26,
              fontWeight: FontWeight.w400,
              color: AppColor.primary,
            ),
            20.height,
            SettingItem(
                icon: AppIcon.vibrate,
                title: AppString.vibrate,
                subTitle: AppString.vibrationWhenScan,
                switchValue: _vibrateEnabled,
                onSwitch: (value) {
                  setState(() {
                    _vibrateEnabled = value;
                  });
                }),

            20.height,
            SettingItem(
                icon: AppIcon.sound,
                title: AppString.beep,
                subTitle: AppString.beepWhenScan,
                switchValue: _beepEnabled,
                onSwitch: (value) {
                  setState(() {
                    _beepEnabled = value;
                  });
                }),
            50.height,

            //================================================Support
            const CommonText(
              text: AppString.support,
              fontSize: 26,
              fontWeight: FontWeight.w400,
              color: AppColor.primary,
            ),
            20.height,
            SettingItem(
                icon: AppIcon.rate,
                title: AppString.rateUs,
                subTitle: AppString.yourBestReward),

            20.height,
            SettingItem(
                icon: AppIcon.share,
                title: AppString.share,
                subTitle: AppString.shareAppOther),
            20.height,
            SettingItem(
                icon: AppIcon.privacy,
                title: AppString.privacyPolicy,
                subTitle: AppString.followOurPolicies),
          ],
        ),
      ),
    );
  }
}
