import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qrscan/feature/component/common_text.dart';
import 'package:qrscan/feature/view/setting_screen/widget/custom_toggle_switch.dart';

// ignore: must_be_immutable
class SettingItem extends StatelessWidget {
  String icon;
  String title;
  String subTitle;
  bool? switchValue;
  VoidCallback? onTap;
  final ValueChanged<bool>? onSwitch;
  SettingItem(
      {super.key,
      required this.icon,
      required this.title,
      required this.subTitle,
      this.switchValue,
      this.onTap,
      this.onSwitch});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 15,
              children: [
                SvgPicture.asset(icon),
                Column(
                  spacing: 5,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: title,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    CommonText(
                      text: subTitle,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    )
                  ],
                )
              ],
            ),
            switchValue != null
                ? CustomToggleSwitch(
                    value: switchValue ?? false,
                    onChanged: onSwitch!,
                  )
                : const SizedBox()
          ],
        ));
  }
}
