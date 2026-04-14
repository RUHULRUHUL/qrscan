// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qrscan/core/constant/app_color.dart';
import 'package:qrscan/core/constant/app_icon.dart';
import 'package:qrscan/core/constant/app_image.dart';
import 'package:qrscan/feature/component/common_image.dart';
import 'package:qrscan/feature/component/common_text.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 13),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.white.withOpacity(0.15),
          blurRadius: 2,
          spreadRadius: 1,
          offset: const Offset(0, 2),
        ),
      ], color: AppColor.black33, borderRadius: BorderRadius.circular(10)),
      child: Row(
        spacing: 10,
        children: [
          const CommonImage(
            imageSrc: AppImage.logo,
            imageType: ImageType.png,
            height: 40,
            width: 40,
            fill: BoxFit.cover,
          ),
          Flexible(
            child: Column(
              spacing: 5,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   const Flexible(
                      child: CommonText(
                        text: "https://itunes.com",
                        color: Color(0xFFD9D9D9),
                      ),
                    ),
                    SvgPicture.asset(AppIcon.delete),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonText(
                      text: "data",
                      color: Color(0xFFD9D9D9),
                      fontSize: 15,
                    ),
                    Flexible(
                      child: CommonText(
                        textAlign: TextAlign.end,
                        text: "16 Dec 2022, 9:30 pm",
                        fontSize: 15,
                        color: Color(0xFFD9D9D9),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
