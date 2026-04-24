import 'dart:io';

import 'package:get/get.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:mobile_scanner/mobile_scanner.dart' hide Barcode;
import 'package:qrscan/feature/view/scanner_screen/widget/scan_result_dialog.dart';

/// ================= CONTROLLER =================
class ScannerController extends GetxController {
  final MobileScannerController mobileScannerController =
      MobileScannerController(
          detectionSpeed: DetectionSpeed.noDuplicates,
          facing: CameraFacing.back,
          torchEnabled: false,
          invertImage: true);

  var isScanned = false.obs;
  var scannedValue = ''.obs;

  void onDetect(BarcodeCapture capture) {
    if (isScanned.value) return;

    for (final barcode in capture.barcodes) {
      final String? code = barcode.rawValue;

      if (code != null) {
        isScanned.value = true;
        scannedValue.value = code;

        mobileScannerController.stop();

        ScanResultDialog.show(
          code: code,
          onScanAgain: restartScanner,
        );

        break;
      }
    }
  }

  void restartScanner() {
    isScanned.value = false;
    scannedValue.value = '';
    mobileScannerController.start();
  }

  void toggleFlash() => mobileScannerController.toggleTorch();

  void switchCamera() => mobileScannerController.switchCamera();

  Future<void> scanFromGallery(String imagePath) async {
    if (imagePath.isEmpty) return;

    final inputImage = InputImage.fromFile(File(imagePath));
    final barcodeScanner = BarcodeScanner();

    try {
      final List<Barcode> barcodes =
          await barcodeScanner.processImage(inputImage);

      if (barcodes.isEmpty) {
        Get.snackbar("Result", "No QR/Barcode found");
        return;
      }

      final String? code = barcodes.first.rawValue;

      if (code != null) {
        isScanned.value = true;
        scannedValue.value = code;

        mobileScannerController.stop();
        ScanResultDialog.show(
          code: code,
          onScanAgain: restartScanner,
        );
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to scan image");
    } finally {
      barcodeScanner.close();
    }
  }

  @override
  void onClose() {
    mobileScannerController.dispose();
    super.onClose();
  }
}
