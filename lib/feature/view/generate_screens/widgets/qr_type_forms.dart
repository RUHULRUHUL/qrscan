import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qrscan/core/constant/app_string.dart';
import 'package:qrscan/core/constant/extentions.dart';
import 'package:qrscan/feature/component/custom_textfield_formd.dart';
import 'package:qrscan/feature/view/generate_screens/controller/qr_generate_controller.dart';

class QrTypeFormFactory extends StatelessWidget {
  final String type;
  const QrTypeFormFactory({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case "text":
        return const _TextQrForm();
      case "web":
        return const _WebsiteQrForm();
      case "wifi":
        return const _WifiQrForm();
      case "event":
        return const _EventQrForm();
      case "contact":
        return const _ContactQrForm();
      case "buissness":
        return const _BusinessQrForm();
      case "location":
        return const _LocationQrForm();
      case "whatsApp":
        return const _WhatsappQrForm();
      case "email":
        return const _EmailQrForm();
      case "twitter":
        return const _TwitterQrForm();
      case "instagram":
        return const _InstagramQrForm();
      case "phone":
        return const _PhoneQrForm();
      default:
        return const SizedBox.shrink();
    }
  }
}

// ===================== Helpers =====================
TextStyle get _darkInputStyle => GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    );

TextStyle get _darkHintStyle => GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.grey,
    );

const Color _darkFill = Color(0xFF3A3A3A);
const Color _darkBorder = Color(0xFF555555);

Widget _darkField({
  required String label,
  required String hint,
  required TextEditingController controller,
  TextInputType keyboardType = TextInputType.text,
  TextInputAction textInputAction = TextInputAction.next,
  int maxLines = 1,
  bool readOnly = false,
  bool isPassword = false,
  VoidCallback? onTap,
  List<TextInputFormatter>? inputFormatters,
}) {
  return CustomTextField(
    titleText: label,
    titleColor: Colors.white,
    hintText: hint,
    controller: controller,
    keyboardType: keyboardType,
    textInputAction: textInputAction,
    maxLines: maxLines,
    readOnly: readOnly,
    isPassword: isPassword,
    onTap: onTap,
    fillColor: _darkFill,
    fieldBorderColor: _darkBorder,
    textStyle: _darkInputStyle,
    hintStyle: _darkHintStyle,
    cursorColor: Colors.white,
    inputFormatters: inputFormatters,
  );
}

// ===================== Text =====================
class _TextQrForm extends StatelessWidget {
  const _TextQrForm();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<QrGenerateController>();
    return _darkField(
      label: AppString.text,
      hint: AppString.enterText,
      controller: c.textController,
      textInputAction: TextInputAction.done,
    );
  }
}

// ===================== Website =====================
class _WebsiteQrForm extends StatelessWidget {
  const _WebsiteQrForm();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<QrGenerateController>();
    return _darkField(
      label: AppString.website,
      hint: AppString.enterWebsiteUrl,
      controller: c.websiteUrlController,
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.done,
    );
  }
}

// ===================== Wi-Fi =====================
class _WifiQrForm extends StatelessWidget {
  const _WifiQrForm();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<QrGenerateController>();
    return Column(
      children: [
        _darkField(
          label: AppString.network,
          hint: AppString.enterNetworkName,
          controller: c.wifiNetworkController,
        ),
        _darkField(
          label: AppString.password,
          hint: AppString.enterPassword,
          controller: c.wifiPasswordController,
          isPassword: true,
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }
}

// ===================== Event =====================
class _EventQrForm extends StatelessWidget {
  const _EventQrForm();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<QrGenerateController>();
    return Column(
      children: [
        _darkField(
          label: AppString.eventName,
          hint: AppString.enterEventName,
          controller: c.eventNameController,
        ),
        _darkField(
          label: AppString.startDateAndTime,
          hint: "12 Dec 2022, 10:40 pm",
          controller: c.eventStartDateController,
          readOnly: true,
          onTap: () => c.pickDateTime(c.eventStartDateController),
        ),
        _darkField(
          label: AppString.endDateAndTime,
          hint: "12 Dec 2022, 10:40 pm",
          controller: c.eventEndDateController,
          readOnly: true,
          onTap: () => c.pickDateTime(c.eventEndDateController),
        ),
        _darkField(
          label: AppString.eventLocation,
          hint: AppString.enterLocation,
          controller: c.eventLocationController,
        ),
        _darkField(
          label: AppString.description,
          hint: AppString.enterDetails,
          controller: c.eventDescriptionController,
          maxLines: 3,
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }
}

// ===================== Contact =====================
class _ContactQrForm extends StatelessWidget {
  const _ContactQrForm();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<QrGenerateController>();
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _darkField(
                label: AppString.firstName,
                hint: AppString.enterName,
                controller: c.contactFirstNameController,
              ),
            ),
            8.width,
            Expanded(
              child: _darkField(
                label: AppString.lastName,
                hint: AppString.enterName,
                controller: c.contactLastNameController,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: _darkField(
                label: AppString.company,
                hint: AppString.enterCompany,
                controller: c.contactCompanyController,
              ),
            ),
            8.width,
            Expanded(
              child: _darkField(
                label: AppString.job,
                hint: AppString.enterJob,
                controller: c.contactJobController,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: _darkField(
                label: AppString.phone,
                hint: AppString.enterPhone,
                controller: c.contactPhoneController,
                keyboardType: TextInputType.phone,
              ),
            ),
            8.width,
            Expanded(
              child: _darkField(
                label: AppString.email,
                hint: AppString.enterEmail,
                controller: c.contactEmailController,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
          ],
        ),
        _darkField(
          label: AppString.website,
          hint: AppString.enterWebsite,
          controller: c.contactWebsiteController,
          keyboardType: TextInputType.url,
        ),
        _darkField(
          label: AppString.address,
          hint: AppString.enterAddress,
          controller: c.contactAddressController,
        ),
        Row(
          children: [
            Expanded(
              child: _darkField(
                label: AppString.city,
                hint: AppString.enterCity,
                controller: c.contactCityController,
              ),
            ),
            8.width,
            Expanded(
              child: _darkField(
                label: AppString.country,
                hint: AppString.enterCountry,
                controller: c.contactCountryController,
                textInputAction: TextInputAction.done,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ===================== Business =====================
class _BusinessQrForm extends StatelessWidget {
  const _BusinessQrForm();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<QrGenerateController>();
    return Column(
      children: [
        _darkField(
          label: AppString.companyName,
          hint: AppString.enterCompanyName,
          controller: c.businessCompanyNameController,
        ),
        _darkField(
          label: AppString.industry,
          hint: AppString.enterIndustry,
          controller: c.businessIndustryController,
        ),
        Row(
          children: [
            Expanded(
              child: _darkField(
                label: AppString.phone,
                hint: AppString.enterPhone,
                controller: c.businessPhoneController,
                keyboardType: TextInputType.phone,
              ),
            ),
            8.width,
            Expanded(
              child: _darkField(
                label: AppString.email,
                hint: AppString.enterEmail,
                controller: c.businessEmailController,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
          ],
        ),
        _darkField(
          label: AppString.website,
          hint: AppString.enterWebsite,
          controller: c.businessWebsiteController,
          keyboardType: TextInputType.url,
        ),
        _darkField(
          label: AppString.address,
          hint: AppString.enterAddress,
          controller: c.businessAddressController,
        ),
        Row(
          children: [
            Expanded(
              child: _darkField(
                label: AppString.city,
                hint: AppString.enterCity,
                controller: c.businessCityController,
              ),
            ),
            8.width,
            Expanded(
              child: _darkField(
                label: AppString.country,
                hint: AppString.enterCountry,
                controller: c.businessCountryController,
                textInputAction: TextInputAction.done,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ===================== Location =====================
class _LocationQrForm extends StatelessWidget {
  const _LocationQrForm();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<QrGenerateController>();
    return _darkField(
      label: AppString.location,
      hint: AppString.enterAddress,
      controller: c.locationAddressController,
      textInputAction: TextInputAction.done,
    );
  }
}

// ===================== WhatsApp =====================
class _WhatsappQrForm extends StatelessWidget {
  const _WhatsappQrForm();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<QrGenerateController>();
    return _darkField(
      label: AppString.whatsAppNumber,
      hint: AppString.enterNumber,
      controller: c.whatsappNumberController,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.done,
    );
  }
}

// ===================== Email =====================
class _EmailQrForm extends StatelessWidget {
  const _EmailQrForm();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<QrGenerateController>();
    return _darkField(
      label: AppString.email,
      hint: AppString.enterEmailAddress,
      controller: c.emailAddressController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
    );
  }
}

// ===================== Twitter =====================
class _TwitterQrForm extends StatelessWidget {
  const _TwitterQrForm();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<QrGenerateController>();
    return _darkField(
      label: AppString.username,
      hint: AppString.enterTwitterUsername,
      controller: c.twitterUsernameController,
      textInputAction: TextInputAction.done,
    );
  }
}

// ===================== Instagram =====================
class _InstagramQrForm extends StatelessWidget {
  const _InstagramQrForm();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<QrGenerateController>();
    return _darkField(
      label: AppString.username,
      hint: AppString.enterInstagramUsername,
      controller: c.instagramUsernameController,
      textInputAction: TextInputAction.done,
    );
  }
}

// ===================== Phone =====================
class _PhoneQrForm extends StatelessWidget {
  const _PhoneQrForm();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<QrGenerateController>();
    return _darkField(
      label: AppString.phoneNumber,
      hint: AppString.enterPhoneNumber,
      controller: c.phoneNumberController,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.done,
    );
  }
}
