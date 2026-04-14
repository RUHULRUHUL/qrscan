// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qrscan/core/constant/app_color.dart';
import 'package:qrscan/core/constant/app_icon.dart';
import 'package:qrscan/feature/component/common_text.dart';
import 'package:qrscan/feature/view/generate_screens/generate_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedIndex = 1;
  // ignore: prefer_const_constructors
  List screenList = [GenerateScreen(), SizedBox(), SizedBox()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.grey[800],
      body: screenList[_selectedIndex],
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return SizedBox(
      height: 110,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          /// 🔲 Background Container
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 80,
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              decoration: BoxDecoration(
                color: AppColor.black33,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.15),
                    blurRadius: 20,
                    spreadRadius: 2,
                    offset: const Offset(0, 8), // নিচে shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(
                    index: 0,
                    icon: AppIcon.generate,
                    label: 'Generate',
                  ),

                  const SizedBox(width: 60), // ✅ center gap

                  _buildNavItem(
                    index: 2,
                    icon: AppIcon.history,
                    label: 'History',
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: -30,
            child: _buildScanButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String icon,
    required String label,
  }) {
    final isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              width: 28,
              height: 28,
              colorFilter: ColorFilter.mode(
                isSelected ? AppColor.primary : const Color(0xFFAAAAAA),
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 4),
            CommonText(
              text: label,
              fontSize: 20,
              color: isSelected ? AppColor.primary : const Color(0xFFAAAAAA),
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildScanButton() {
    final isSelected = _selectedIndex == 1;

    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = 1),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColor.primary,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColor.primary.withOpacity(0.5),
                    blurRadius: 16,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: Center(
          child: SvgPicture.asset(
            AppIcon.scan,
            width: 30,
            height: 30,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
