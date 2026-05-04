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

  static final Map<String, GlobalKey<FormState>> formKeys = {
    'text': GlobalKey<FormState>(),
    'web': GlobalKey<FormState>(),
    'wifi': GlobalKey<FormState>(),
    'event': GlobalKey<FormState>(),
    'contact': GlobalKey<FormState>(),
    'buissness': GlobalKey<FormState>(),
    'location': GlobalKey<FormState>(),
    'whatsApp': GlobalKey<FormState>(),
    'email': GlobalKey<FormState>(),
    'twitter': GlobalKey<FormState>(),
    'instagram': GlobalKey<FormState>(),
    'phone': GlobalKey<FormState>(),
  };

  static bool validateForm(String type) {
    final formKey = formKeys[type];
    return formKey?.currentState?.validate() ?? false;
  }

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
  String? Function(String?)? validator,
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
    validator: (value) => validator != null ? validator(value) : null,
  );
}

// ===================== Text =====================
class _TextQrForm extends StatelessWidget {
  const _TextQrForm();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<QrGenerateController>();
    return Form(
      key: QrTypeFormFactory.formKeys['text'],
      child: _darkField(
        label: AppString.text,
        hint: AppString.enterText,
        controller: c.textController,
        textInputAction: TextInputAction.done,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Text is required';
          }
          return null;
        },
      ),
    );
  }
}

// ===================== Website =====================
class _WebsiteQrForm extends StatelessWidget {
  const _WebsiteQrForm();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<QrGenerateController>();
    return Form(
      key: QrTypeFormFactory.formKeys['web'],
      child: _darkField(
        label: AppString.website,
        hint: AppString.enterWebsiteUrl,
        controller: c.websiteUrlController,
        keyboardType: TextInputType.url,
        textInputAction: TextInputAction.done,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Website URL is required';
          }
          return null;
        },
      ),
    );
  }
}

// ===================== Wi-Fi =====================
class _WifiQrForm extends StatelessWidget {
  const _WifiQrForm();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<QrGenerateController>();
    return Form(
      key: QrTypeFormFactory.formKeys['wifi'],
      child: Column(
        children: [
          _darkField(
            label: AppString.network,
            hint: AppString.enterNetworkName,
            controller: c.wifiNetworkController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Network name is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _darkField(
            label: AppString.password,
            hint: AppString.enterPassword,
            controller: c.wifiPasswordController,
            isPassword: true,
            textInputAction: TextInputAction.done,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password is required';
              }
              if (value.length < 8) {
                return 'Password must be at least 8 characters';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}

// ===================== Event =====================
class _EventQrForm extends StatelessWidget {
  const _EventQrForm();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<QrGenerateController>();
    return Form(
      key: QrTypeFormFactory.formKeys['event'],
      child: Column(
        children: [
          _darkField(
            label: AppString.eventName,
            hint: AppString.enterEventName,
            controller: c.eventNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Event name is required';
              }
              return null;
            },
          ),
          _darkField(
            label: AppString.startDateAndTime,
            hint: "12 Dec 2022, 10:40 pm",
            controller: c.eventStartDateController,
            readOnly: true,
            onTap: () => c.pickDateTime(c.eventStartDateController),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Start date is required';
              }
              return null;
            },
          ),
          _darkField(
            label: AppString.endDateAndTime,
            hint: "12 Dec 2022, 10:40 pm",
            controller: c.eventEndDateController,
            readOnly: true,
            onTap: () => c.pickDateTime(c.eventEndDateController),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'End date is required';
              }
              return null;
            },
          ),
          _darkField(
            label: AppString.eventLocation,
            hint: AppString.enterLocation,
            controller: c.eventLocationController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Location is required';
              }
              return null;
            },
          ),
          _darkField(
            label: AppString.description,
            hint: AppString.enterDetails,
            controller: c.eventDescriptionController,
            maxLines: 3,
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }
}

// ===================== Contact =====================
class _ContactQrForm extends StatelessWidget {
  const _ContactQrForm();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<QrGenerateController>();
    return Form(
      key: QrTypeFormFactory.formKeys['contact'],
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _darkField(
                  label: AppString.firstName,
                  hint: AppString.enterName,
                  controller: c.contactFirstNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'First name required';
                    }
                    return null;
                  },
                ),
              ),
              8.width,
              Expanded(
                child: _darkField(
                  label: AppString.lastName,
                  hint: AppString.enterName,
                  controller: c.contactLastNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Last name required';
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone required';
                    }
                    if (!RegExp(r'^\d{10,}$').hasMatch(value.replaceAll(RegExp(r'\D'), ''))) {
                      return 'Enter valid phone number';
                    }
                    return null;
                  },
                ),
              ),
              8.width,
              Expanded(
                child: _darkField(
                  label: AppString.email,
                  hint: AppString.enterEmail,
                  controller: c.contactEmailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email required';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Enter valid email';
                    }
                    return null;
                  },
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
      ),
    );
  }
}

// ===================== Business =====================
class _BusinessQrForm extends StatelessWidget {
  const _BusinessQrForm();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<QrGenerateController>();
    return Form(
      key: QrTypeFormFactory.formKeys['buissness'],
      child: Column(
        children: [
          _darkField(
            label: AppString.companyName,
            hint: AppString.enterCompanyName,
            controller: c.businessCompanyNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Company name is required';
              }
              return null;
            },
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone required';
                    }
                    if (!RegExp(r'^\d{10,}$').hasMatch(value.replaceAll(RegExp(r'\D'), ''))) {
                      return 'Enter valid phone number';
                    }
                    return null;
                  },
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
      ),
    );
  }
}

// ===================== Location =====================
class _LocationQrForm extends StatelessWidget {
  const _LocationQrForm();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<QrGenerateController>();
    return Form(
      key: QrTypeFormFactory.formKeys['location'],
      child: _darkField(
        label: AppString.location,
        hint: AppString.enterAddress,
        controller: c.locationAddressController,
        textInputAction: TextInputAction.done,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Location is required';
          }
          if (value.length < 3) {
            return 'Location must be at least 3 characters';
          }
          return null;
        },
      ),
    );
  }
}

// ===================== WhatsApp =====================
class _WhatsappQrForm extends StatelessWidget {
  const _WhatsappQrForm();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<QrGenerateController>();
    return Form(
      key: QrTypeFormFactory.formKeys['whatsApp'],
      child: _darkField(
        label: AppString.whatsAppNumber,
        hint: AppString.enterNumber,
        controller: c.whatsappNumberController,
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.done,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'WhatsApp number is required';
          }
          return null;
        },
      ),
    );
  }
}

// ===================== Email =====================
class _EmailQrForm extends StatelessWidget {
  const _EmailQrForm();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<QrGenerateController>();
    return Form(
      key: QrTypeFormFactory.formKeys['email'],
      child: _darkField(
        label: AppString.email,
        hint: AppString.enterEmailAddress,
        controller: c.emailAddressController,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.done,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Email is required';
          }
          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
            return 'Enter valid email';
          }
          return null;
        },
      ),
    );
  }
}

// ===================== Twitter =====================
class _TwitterQrForm extends StatelessWidget {
  const _TwitterQrForm();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<QrGenerateController>();
    return Form(
      key: QrTypeFormFactory.formKeys['twitter'],
      child: _darkField(
        label: AppString.username,
        hint: AppString.enterTwitterUsername,
        controller: c.twitterUsernameController,
        textInputAction: TextInputAction.done,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Twitter username is required';
          }
          return null;
        },
      ),
    );
  }
}

// ===================== Instagram =====================
class _InstagramQrForm extends StatelessWidget {
  const _InstagramQrForm();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<QrGenerateController>();
    return Form(
      key: QrTypeFormFactory.formKeys['instagram'],
      child: _darkField(
        label: AppString.username,
        hint: AppString.enterInstagramUsername,
        controller: c.instagramUsernameController,
        textInputAction: TextInputAction.done,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Instagram username is required';
          }
          return null;
        },
      ),
    );
  }
}

// ===================== Phone =====================
class _PhoneQrForm extends StatelessWidget {
  const _PhoneQrForm();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<QrGenerateController>();
    return Form(
      key: QrTypeFormFactory.formKeys['phone'],
      child: _darkField(
        label: AppString.phoneNumber,
        hint: AppString.enterPhoneNumber,
        controller: c.phoneNumberController,
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.done,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Phone number is required';
          }
          return null;
        },
      ),
    );
  }
}
