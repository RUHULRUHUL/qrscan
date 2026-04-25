import 'dart:io';

import 'package:flutter/services.dart';
import 'package:beep_sound/beep_sound.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:mobile_scanner/mobile_scanner.dart' hide Barcode;
import 'package:qrscan/core/helper/hive_helper.dart';
import 'package:qrscan/core/model/qr_history_item.dart';
import 'package:qrscan/feature/view/history_screen/controller/history_controller.dart';
import 'package:qrscan/feature/view/scanner_screen/widget/scan_result_dialog.dart';
import 'package:vibration/vibration.dart';

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

        _handleScanSuccess(code);

        ScanResultDialog.show(
          code: code,
          onScanAgain: restartScanner,
        );

        break;
      }
    }
  }

  void _handleScanSuccess(String code) async {
    final hive = HiveHelper();

    // Vibrate if enabled
    if (hive.vibrateOnScan) {
      try {
        // Pattern: wait 0ms, vibrate 300ms, wait 100ms, vibrate 300ms
        await Vibration.vibrate(pattern: [0, 300, 100, 300]);
      } catch (_) {
        // Fallback to heavy haptic feedback
        HapticFeedback.heavyImpact();
      }
    }

    // Beep if enabled
    if (hive.beepOnScan) {
      BeepSound().playSysSound(AndroidSoundIDs.toneCdmaAbbrAlert.value);
    }

    // Save to history
    await hive.addHistory(QrHistoryItem(
      id: hive.generateId(),
      content: code,
      type: 'scan',
      qrType: _detectQrType(code),
      timestamp: DateTime.now(),
      title: code.length > 40 ? '${code.substring(0, 40)}...' : code,
    ));

    // Refresh history if on history screen
    if (Get.isRegistered<HistoryController>()) {
      Get.find<HistoryController>().refreshHistory();
    }
  }

  String _detectQrType(String code) {
    final lower = code.toLowerCase();
    if (lower.startsWith('http')) return 'web';
    if (lower.startsWith('wifi:')) return 'wifi';
    if (lower.startsWith('mailto:')) return 'email';
    if (lower.startsWith('tel:')) return 'phone';
    if (lower.startsWith('begin:vcard')) return 'contact';
    if (lower.startsWith('begin:vevent')) return 'event';
    if (lower.startsWith('https://wa.me/')) return 'whatsApp';
    return 'text';
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
        _handleScanSuccess(code);
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
