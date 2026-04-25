// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qrscan/core/constant/app_color.dart';
import 'package:qrscan/feature/component/common_text.dart';

class QrBuilderCard extends StatelessWidget {
  String title;
  String icon;
  VoidCallback onTap;
  QrBuilderCard({super.key, required this.title, required this.icon,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: AppColor.black33,
              border: Border.all(color: AppColor.primary),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: SvgPicture.asset(
                icon,
                color: AppColor.primary,
              ),
            ),
          ),
      
          Positioned(
            top: -12, // ✅ half outside effect
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius: BorderRadius.circular(5),
              ),
              child: CommonText(
                text: title,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColor.textBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
