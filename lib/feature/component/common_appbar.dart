import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:qrscan/core/constant/app_icon.dart';
import 'package:qrscan/core/constant/extentions.dart';
import 'package:qrscan/feature/component/common_text.dart';
import 'package:qrscan/route/approute.dart';

// ignore: must_be_immutable
class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Color titleColor;
  final VoidCallback? onBackTap;
  final bool isCenterTitle;
  final VoidCallback? onMenuClick;
  bool isBack;

  CommonAppBar({
    super.key,
    required this.title,
    this.actions,
    this.titleColor = const Color(0xFFFFFFFF),
    this.onBackTap,
    this.isCenterTitle = false,
    this.onMenuClick,
    this.isBack = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: isCenterTitle,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: isBack
            ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: InkWell(
                      onTap: onBackTap ?? () => Navigator.pop(context),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.arrow_back_ios,
                            size: 20,
                            color: Color(0xFFFFFFFF),
                          ),
                          Flexible(
                            child: CommonText(
                              text: title,
                              fontSize: 20,
                              left: 0,
                              fontWeight: FontWeight.w600,
                              color: titleColor,
                            ).start,
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.toNamed(AppRoute.settingScreen);
                    },
                    icon: SvgPicture.asset(
                      AppIcon.menu,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFFFDB623),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              )
            : Row(
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
                  IconButton(
                    onPressed: () {
                      Get.toNamed(AppRoute.settingScreen);
                    },
                    icon: SvgPicture.asset(
                      AppIcon.menu,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFFFDB623),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
