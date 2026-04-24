// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qrscan/core/helper/other_helper.dart';
import 'package:qrscan/feature/view/scanner_screen/controller/scanner_controller.dart';

/// ================= SCREEN =================
class ScannerScreen extends StatelessWidget {
  ScannerScreen({super.key});

  final ScannerController controller = Get.find<ScannerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          /// Camera
          MobileScanner(
            controller: controller.mobileScannerController,
            onDetect: controller.onDetect,
          ),

          /// 🔥 Blur + Dark Overlay
          _ScannerOverlay(),

          /// 🔥 Scanner Box with Animation
          const Center(child: ScannerBox()),

          /// Top Buttons
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () async {
                    String image = await OtherHelper.openGallery() ?? "";
                    if (image.isNotEmpty) {
                      controller.scanFromGallery(image);
                    }
                  },
                  icon: const Icon(Icons.image, color: Colors.white),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: controller.toggleFlash,
                      icon: const Icon(Icons.flash_on, color: Colors.white),
                    ),
                    IconButton(
                      onPressed: controller.switchCamera,
                      icon: const Icon(Icons.cameraswitch, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),

          /// Bottom Text
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: Obx(() => Text(
                    controller.isScanned.value
                        ? "Scanned ✔"
                        : "Scan a QR or Barcode",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 16,
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

/// ================= OVERLAY =================
class _ScannerOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Blur background
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            color: Colors.black.withOpacity(0.5),
          ),
        ),

        /// Transparent cutout
        Center(
          child: Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ],
    );
  }
}

/// ================= SCANNER BOX =================
class ScannerBox extends StatefulWidget {
  const ScannerBox({super.key});

  @override
  State<ScannerBox> createState() => _ScannerBoxState();
}

class _ScannerBoxState extends State<ScannerBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 230).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      height: 260,
      child: Stack(
        children: [
          /// Border
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 3),
              borderRadius: BorderRadius.circular(16),
            ),
          ),

          /// 🔥 Animated scan line
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Positioned(
                top: _animation.value,
                left: 0,
                right: 0,
                child: Container(
                  height: 3,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.greenAccent,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
