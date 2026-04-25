import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qrscan/feature/component/common_text.dart';
import 'package:qrscan/feature/view/setting_screen/widget/custom_toggle_switch.dart';

class SettingItem extends StatelessWidget {
  final String icon;
  final String title;
  final String subTitle;
  final bool? switchValue;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onSwitch;

  const SettingItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
    this.switchValue,
    this.onTap,
    this.onSwitch,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(icon),
                const SizedBox(width: 15),
                Column(
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
                      color: Colors.white70,
                    ),
                  ],
                ),
              ],
            ),
            if (switchValue != null)
              CustomToggleSwitch(
                value: switchValue ?? false,
                onChanged: onSwitch!,
              ),
          ],
        ),
      ),
    );
  }
}
