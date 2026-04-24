import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
class OtherHelper {


  static Future<String?> openGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? getImages =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (getImages == null) return null;
    if (kDebugMode) {
      print(getImages.path);
    }

    return getImages.path;
  }

}
