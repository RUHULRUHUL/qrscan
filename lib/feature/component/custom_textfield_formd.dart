import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qrscan/core/constant/app_icon.dart';
import 'package:qrscan/feature/component/common_text.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    this.title,
    this.titleSuffixWidget,
    this.inputFormatters,
    this.onFieldSubmitted,
    this.onSaved,
    this.controller,
    this.focusNode,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.cursorColor = Colors.black,
    this.textAlignVertical = TextAlignVertical.center,
    this.textAlign = TextAlign.start,
    this.onChanged,
    this.maxLines = 1,
    this.validator,
    this.labelText,
    this.hintText,
    this.titleText = "",
    this.titleColor = Colors.black,
    this.optionalText = "",
    this.textStyle,
    this.hintStyle,
    this.fillColor = Colors.white,
    this.suffixIcon,
    this.suffixIconColor,
    this.fieldBorderRadius,
    this.fieldBorderColor = Colors.amberAccent,
    this.isPassword = false,
    this.isPrefixIcon = true,
    this.readOnly = false,
    this.maxLength,
    super.key,
    this.prefixIcon,
    this.storyWordCount = "",
    this.onTap,
  });

  final String? title;
  final Widget? titleSuffixWidget;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Color cursorColor;
  final TextAlignVertical? textAlignVertical;
  final TextAlign textAlign;
  final int? maxLines;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function(String?)? onSaved;
  final FormFieldValidator? validator;
  final String? labelText;
  final String? hintText;
  final String titleText;
  final Color titleColor;
  final String optionalText;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final Color? fillColor;
  final Color? suffixIconColor;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? fieldBorderRadius;
  final VoidCallback? onTap;

  final Color fieldBorderColor;
  final bool isPassword;
  final bool isPrefixIcon;
  final bool readOnly;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final String storyWordCount;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.titleText.isNotEmpty) ...[
            CommonText(
              text: widget.titleText,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: widget.titleColor,
            ),
          ],
          TextFormField(
            onTap: widget.onTap,
            inputFormatters: widget.inputFormatters,
            onFieldSubmitted: widget.onFieldSubmitted,
            onSaved: widget.onSaved,
            readOnly: widget.readOnly,
            controller: widget.controller,
            focusNode: widget.focusNode,
            maxLength: widget.maxLength,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            cursorColor: widget.cursorColor,
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            style: widget.textStyle ??
                GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF101828),
                ),
            onChanged: widget.onChanged,
            maxLines: widget.maxLines,
            obscureText: widget.isPassword ? obscureText : false,
            validator: widget.validator,
            showCursor:
                widget.keyboardType == TextInputType.none ? false : true,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: 12.h,
                horizontal: 14.w,
              ),
              labelText: widget.labelText,
              hintText: widget.hintText,
              labelStyle: widget.textStyle,
              hintStyle: widget.hintStyle ??
                  GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFFA9B0C0),
                  ),
              fillColor: widget.fillColor,
              filled: true,
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.isPassword
                  ? GestureDetector(
                      onTap: toggle,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 10,
                          bottom: 10,
                        ),
                        child: obscureText
                            ? SizedBox(
                                height: 20.h,
                                width: 20.w,
                                child: SvgPicture.asset(AppIcon.visibilityOff),
                              )
                            : SizedBox(
                                height: 20.h,
                                width: 20.w,
                                child: SvgPicture.asset(AppIcon.visibility),
                              ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: widget.suffixIcon,
                    ),
              suffixIconColor: widget.suffixIconColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  widget.fieldBorderRadius ?? 12.r,
                ),
                borderSide: BorderSide(
                  color: widget.fieldBorderColor,
                  width: 1.5,
                ),
                gapPadding: 0,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  widget.fieldBorderRadius ?? 12.r,
                ),
                borderSide: BorderSide(
                  color: widget.fieldBorderColor,
                  width: 1.5,
                ),
                gapPadding: 0,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  widget.fieldBorderRadius ?? 12.r,
                ),
                borderSide: BorderSide(
                  color: widget.fieldBorderColor,
                  width: 1.5,
                ),
                gapPadding: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}
