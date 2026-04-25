import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrscan/core/constant/app_color.dart';
import 'package:qrscan/core/constant/app_icon.dart';
import 'package:qrscan/core/constant/app_string.dart';
import 'package:qrscan/core/constant/extentions.dart';
import 'package:qrscan/core/helper/hive_helper.dart';
import 'package:qrscan/feature/component/common_text.dart';
import 'package:qrscan/feature/view/setting_screen/widget/setting_item.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final HiveHelper _hive = HiveHelper();
  bool _vibrateEnabled = false;
  bool _beepEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() {
    setState(() {
      _vibrateEnabled = _hive.vibrateOnScan;
      _beepEnabled = _hive.beepOnScan;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
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
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Icon(
                  Icons.keyboard_arrow_left,
                  color: Color(0xFFFDB623),
                  size: 30,
                ),
              ),
            ),
            30.height,
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
              onSwitch: (value) async {
                await _hive.setVibrate(value);
                setState(() {
                  _vibrateEnabled = value;
                });
              },
            ),
            20.height,
            SettingItem(
              icon: AppIcon.sound,
              title: AppString.beep,
              subTitle: AppString.beepWhenScan,
              switchValue: _beepEnabled,
              onSwitch: (value) async {
                await _hive.setBeep(value);
                setState(() {
                  _beepEnabled = value;
                });
              },
            ),
            50.height,
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
              subTitle: AppString.yourBestReward,
              onTap: () {},
            ),
            20.height,
            SettingItem(
              icon: AppIcon.share,
              title: AppString.share,
              subTitle: AppString.shareAppOther,
              onTap: () {
                Share.share('Check out Mino QR Scanner & Generator app!');
              },
            ),
            20.height,
            SettingItem(
              icon: AppIcon.privacy,
              title: AppString.privacyPolicy,
              subTitle: AppString.followOurPolicies,
              onTap: () async {
                final uri = Uri.parse('https://www.google.com');
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
