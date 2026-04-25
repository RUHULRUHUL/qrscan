import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qrscan/core/constant/app_color.dart';
import 'package:qrscan/feature/component/common_text.dart';

class QrBuilderCard extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;

  const QrBuilderCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

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
                colorFilter: const ColorFilter.mode(
                  AppColor.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          Positioned(
            top: -12,
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
