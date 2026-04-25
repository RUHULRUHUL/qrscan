import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qrscan/core/constant/app_color.dart';
import 'package:qrscan/core/constant/app_icon.dart';
import 'package:qrscan/core/constant/extentions.dart';
import 'package:qrscan/core/model/qr_history_item.dart';
import 'package:qrscan/feature/component/common_text.dart';
import 'package:qrscan/feature/view/history_screen/history_detail_screen.dart';

class HistoryCard extends StatelessWidget {
  final QrHistoryItem item;
  final VoidCallback onDelete;

  const HistoryCard({
    super.key,
    required this.item,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => HistoryDetailScreen(item: item));
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.08),
              blurRadius: 2,
              spreadRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColor.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: SvgPicture.asset(
                  _getIconForType(item.qrType),
                  width: 22,
                  height: 22,
                  colorFilter: const ColorFilter.mode(
                    AppColor.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            12.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    text: item.title ?? item.content,
                    color: const Color(0xFFD9D9D9),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                  ),
                  4.height,
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: item.type == 'scan'
                              ? Colors.blue.withValues(alpha: 0.2)
                              : Colors.green.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          item.type == 'scan' ? 'Scanned' : 'Generated',
                          style: TextStyle(
                            color: item.type == 'scan'
                                ? Colors.blue.shade300
                                : Colors.green.shade300,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      8.width,
                      Text(
                        _formatDate(item.timestamp),
                        style: const TextStyle(
                          color: Color(0xFF888888),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onDelete,
              icon: SvgPicture.asset(
                AppIcon.delete,
                width: 20,
                height: 20,
                colorFilter: const ColorFilter.mode(
                  Colors.redAccent,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getIconForType(String qrType) {
    switch (qrType) {
      case 'web':
        return AppIcon.web;
      case 'wifi':
        return AppIcon.wifi;
      case 'email':
        return AppIcon.email;
      case 'phone':
        return AppIcon.phone;
      case 'contact':
        return AppIcon.contact;
      case 'event':
        return AppIcon.event;
      case 'whatsApp':
        return AppIcon.whatsapp;
      case 'text':
        return AppIcon.text;
      default:
        return AppIcon.scan;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inDays < 1) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${date.day}/${date.month}/${date.year}';
  }
}
