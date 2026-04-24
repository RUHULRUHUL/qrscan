import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qrscan/core/constant/app_color.dart';
import 'package:qrscan/core/constant/extentions.dart';
import 'package:qrscan/feature/component/common_text.dart';
class CommonButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String titleText;
  final Color titleColor;
  final Color buttonColor;
  final Color? borderColor;
  final double borderWidth;
  final double titleSize;
  final FontWeight titleWeight;
  final double buttonRadius;
  final double buttonHeight;
  final double buttonWidth;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double strokeWidth;
  final bool isLoading;

  const CommonButton({
    this.onTap,
    required this.titleText,
    this.titleColor = Colors.white,
    this.buttonColor = AppColor.primary,
    this.titleSize = 18,
    this.buttonRadius = 14,
    this.titleWeight = FontWeight.w700,
    this.buttonHeight = 56,
    this.borderWidth = 1,
    this.isLoading = false,
    this.buttonWidth = double.infinity,
    this.borderColor = AppColor.primary,
    this.strokeWidth = 4,
    this.prefixIcon,
    this.suffixIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight.h,
      width: buttonWidth.w,
      child: Ink(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.white.withOpacity(0.12),
              offset: const Offset(0, 3),
              blurRadius: 3,
              spreadRadius: 0,
            ),
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.03),
              offset: const Offset(0, 1),
              blurRadius: 1,
              spreadRadius: -0.5,
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: onTap,
          style: ButtonStyle(
            padding: WidgetStateProperty.all(EdgeInsets.zero),
            backgroundColor: WidgetStateProperty.all(buttonColor),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(buttonRadius.r),
                side: BorderSide(
                  color: borderColor ?? AppColor.primary,
                  width: borderWidth.w,
                ),
              ),
            ),
            elevation: WidgetStateProperty.all(0),
          ),
          child: isLoading
              ? Platform.isIOS
                    ? const CupertinoActivityIndicator(color: Colors.white)
                    : CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: strokeWidth,
                      )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (prefixIcon != null) prefixIcon!,
                    if (prefixIcon != null) 8.width,
                    CommonText(
                      text: titleText,
                      fontSize: titleSize,
                      fontWeight: titleWeight,
                      textAlign: TextAlign.center,
                      color: titleColor,
                    ),

                    if (suffixIcon != null) suffixIcon!,
                    if (suffixIcon != null) 8.width,
                  ],
                ),
        ),
      ),
    );
  }
}
