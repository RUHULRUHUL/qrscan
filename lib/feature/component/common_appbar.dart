// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:qrscan/core/constant/app_icon.dart';
import 'package:qrscan/core/constant/extentions.dart';
import 'package:qrscan/feature/component/common_text.dart';
import 'package:qrscan/route/approute.dart';
class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Color titleColor;
  final VoidCallback? onBackTap;
  final bool isCenterTitle;
  final VoidCallback? onMenuClick;

  const CommonAppBar({
    super.key,
    required this.title,
    this.actions,
    this.titleColor = const Color(0xFFFFFFFF),
    this.onBackTap,
    this.isCenterTitle = false,
    this.onMenuClick
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      automaticallyImplyLeading: false,
      title: InkWell(
        onTap: onBackTap ?? () => Navigator.pop(context),
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: CommonText(
                  text: title,
                  fontSize: 24,
                  top: 5,
                  left: 0,
                  fontWeight: FontWeight.w600,
                  color: titleColor,
                ).start,
              ),
              IconButton(onPressed: (){
                Get.toNamed(AppRoute.settingScreen);
              }, icon: SvgPicture.asset(AppIcon.menu,color: const Color(0xFFFDB623),))
            ],
          ),
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
