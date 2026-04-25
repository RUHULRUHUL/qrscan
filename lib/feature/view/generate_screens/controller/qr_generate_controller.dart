import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qrscan/core/constant/app_icon.dart';
import 'package:qrscan/core/constant/app_string.dart';

class QrGenerateController extends GetxController {
  List qrItem = [
    {"title": AppString.text, "icon": AppIcon.text, "type": "text"},
    {"title": AppString.website, "icon": AppIcon.web, "type": "web"},
    {"title": AppString.wifi, "icon": AppIcon.wifi, "type": "wifi"},
    {"title": AppString.event, "icon": AppIcon.event, "type": "event"},
    {"title": AppString.contact, "icon": AppIcon.contact, "type": "contact"},
    {"title": AppString.business, "icon": AppIcon.buissness, "type": "buissness"},
    {"title": AppString.location, "icon": AppIcon.location, "type": "location"},
    {"title": AppString.whatsapp, "icon": AppIcon.whatsapp, "type": "whatsApp"},
    {"title": AppString.email, "icon": AppIcon.email, "type": "email"},
    {"title": AppString.twitter, "icon": AppIcon.twitter, "type": "twitter"},
    {"title": AppString.instagram, "icon": AppIcon.instagram, "type": "instagram"},
    {"title": AppString.telephone, "icon": AppIcon.phone, "type": "phone"},
  ];

  // Text
  final textController = TextEditingController();

  // Website
  final websiteUrlController = TextEditingController();

  // Wi-Fi
  final wifiNetworkController = TextEditingController();
  final wifiPasswordController = TextEditingController();

  // Event
  final eventNameController = TextEditingController();
  final eventStartDateController = TextEditingController();
  final eventEndDateController = TextEditingController();
  final eventLocationController = TextEditingController();
  final eventDescriptionController = TextEditingController();

  // Contact
  final contactFirstNameController = TextEditingController();
  final contactLastNameController = TextEditingController();
  final contactCompanyController = TextEditingController();
  final contactJobController = TextEditingController();
  final contactPhoneController = TextEditingController();
  final contactEmailController = TextEditingController();
  final contactWebsiteController = TextEditingController();
  final contactAddressController = TextEditingController();
  final contactCityController = TextEditingController();
  final contactCountryController = TextEditingController();

  // Business
  final businessCompanyNameController = TextEditingController();
  final businessIndustryController = TextEditingController();
  final businessPhoneController = TextEditingController();
  final businessEmailController = TextEditingController();
  final businessWebsiteController = TextEditingController();
  final businessAddressController = TextEditingController();
  final businessCityController = TextEditingController();
  final businessCountryController = TextEditingController();

  // Location
  final locationAddressController = TextEditingController();

  // WhatsApp
  final whatsappNumberController = TextEditingController();

  // Twitter
  final twitterUsernameController = TextEditingController();

  // Email
  final emailAddressController = TextEditingController();

  // Instagram
  final instagramUsernameController = TextEditingController();

  // Phone
  final phoneNumberController = TextEditingController();

  String generatedQrData = "";

  String generateQrContent(String type) {
    switch (type) {
      case "text":
        generatedQrData = textController.text.trim();
        break;
      case "web":
        var url = websiteUrlController.text.trim();
        if (url.isNotEmpty && !url.startsWith("http")) {
          url = "https://$url";
        }
        generatedQrData = url;
        break;
      case "wifi":
        final ssid = wifiNetworkController.text.trim();
        final pass = wifiPasswordController.text.trim();
        generatedQrData = "WIFI:S:$ssid;T:WPA;P:$pass;;";
        break;
      case "event":
        final name = eventNameController.text.trim();
        final start = eventStartDateController.text.trim();
        final end = eventEndDateController.text.trim();
        final loc = eventLocationController.text.trim();
        final desc = eventDescriptionController.text.trim();
        generatedQrData =
            "BEGIN:VEVENT\nSUMMARY:$name\nDTSTART:$start\nDTEND:$end\nLOCATION:$loc\nDESCRIPTION:$desc\nEND:VEVENT";
        break;
      case "contact":
        generatedQrData = _buildVCard(
          firstName: contactFirstNameController.text.trim(),
          lastName: contactLastNameController.text.trim(),
          org: contactCompanyController.text.trim(),
          title: contactJobController.text.trim(),
          tel: contactPhoneController.text.trim(),
          email: contactEmailController.text.trim(),
          url: contactWebsiteController.text.trim(),
          adr:
              "${contactAddressController.text.trim()}, ${contactCityController.text.trim()}, ${contactCountryController.text.trim()}",
        );
        break;
      case "buissness":
        generatedQrData = _buildVCard(
          org: businessCompanyNameController.text.trim(),
          title: businessIndustryController.text.trim(),
          tel: businessPhoneController.text.trim(),
          email: businessEmailController.text.trim(),
          url: businessWebsiteController.text.trim(),
          adr:
              "${businessAddressController.text.trim()}, ${businessCityController.text.trim()}, ${businessCountryController.text.trim()}",
        );
        break;
      case "location":
        generatedQrData = locationAddressController.text.trim();
        break;
      case "whatsApp":
        final num = whatsappNumberController.text.trim();
        generatedQrData = "https://wa.me/$num";
        break;
      case "email":
        generatedQrData = "mailto:${emailAddressController.text.trim()}";
        break;
      case "twitter":
        final user = twitterUsernameController.text.trim();
        generatedQrData = "https://twitter.com/$user";
        break;
      case "instagram":
        final user = instagramUsernameController.text.trim();
        generatedQrData = "https://instagram.com/$user";
        break;
      case "phone":
        generatedQrData = "tel:${phoneNumberController.text.trim()}";
        break;
      default:
        generatedQrData = "";
    }
    update();
    return generatedQrData;
  }

  String _buildVCard({
    String firstName = "",
    String lastName = "",
    String org = "",
    String title = "",
    String tel = "",
    String email = "",
    String url = "",
    String adr = "",
  }) {
    return "BEGIN:VCARD\nVERSION:3.0\nFN:$firstName $lastName\nORG:$org\nTITLE:$title\nTEL:$tel\nEMAIL:$email\nURL:$url\nADR:$adr\nEND:VCARD";
  }

  Future<void> pickDateTime(TextEditingController controller) async {
    final date = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFFDB623),
              onPrimary: Colors.black,
              surface: Color(0xFF333333),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (date == null) return;

    final time = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFFDB623),
              onPrimary: Colors.black,
              surface: Color(0xFF333333),
              onSurface: Colors.white,
            ),
            timePickerTheme: const TimePickerThemeData(
              backgroundColor: Color(0xFF333333),
              hourMinuteTextColor: Colors.white,
              dialHandColor: Color(0xFFFDB623),
              dialTextColor: Colors.white,
              entryModeIconColor: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (time == null) return;

    final dt = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    controller.text = DateFormat("dd MMM yyyy, h:mm a").format(dt);
  }

  @override
  void onClose() {
    textController.dispose();
    websiteUrlController.dispose();
    wifiNetworkController.dispose();
    wifiPasswordController.dispose();
    eventNameController.dispose();
    eventStartDateController.dispose();
    eventEndDateController.dispose();
    eventLocationController.dispose();
    eventDescriptionController.dispose();
    contactFirstNameController.dispose();
    contactLastNameController.dispose();
    contactCompanyController.dispose();
    contactJobController.dispose();
    contactPhoneController.dispose();
    contactEmailController.dispose();
    contactWebsiteController.dispose();
    contactAddressController.dispose();
    contactCityController.dispose();
    contactCountryController.dispose();
    businessCompanyNameController.dispose();
    businessIndustryController.dispose();
    businessPhoneController.dispose();
    businessEmailController.dispose();
    businessWebsiteController.dispose();
    businessAddressController.dispose();
    businessCityController.dispose();
    businessCountryController.dispose();
    locationAddressController.dispose();
    whatsappNumberController.dispose();
    twitterUsernameController.dispose();
    emailAddressController.dispose();
    instagramUsernameController.dispose();
    phoneNumberController.dispose();
    super.onClose();
  }
}
