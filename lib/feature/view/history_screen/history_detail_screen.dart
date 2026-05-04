import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrscan/core/constant/app_color.dart';
import 'package:qrscan/core/constant/extentions.dart';
import 'package:qrscan/core/model/qr_history_item.dart';
import 'package:qrscan/feature/component/common_appbar.dart';
import 'package:qrscan/feature/component/common_button.dart';
import 'package:qrscan/feature/component/common_text.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class HistoryDetailScreen extends StatelessWidget {
  final QrHistoryItem item;

  const HistoryDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black33,
      appBar: CommonAppBar(
        title: item.type == 'scan' ? 'Scan Details' : 'Generated QR',
        isBack: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            children: [
              // QR Preview
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    QrImageView(
                      data: item.content,
                      version: QrVersions.auto,
                      size: 220,
                      backgroundColor: Colors.white,
                    ),
                    16.height,
                    Text(
                      item.content,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 13,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              20.height,
              // Info Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF3A3A3A),
                  borderRadius: BorderRadius.circular(16),
                  border: const Border(
                    top: BorderSide(color: AppColor.primary, width: 2),
                    bottom: BorderSide(color: AppColor.primary, width: 2),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow('Type', item.qrType.toUpperCase()),
                    _buildInfoRow('Category', item.type == 'scan' ? 'Scanned' : 'Generated'),
                    _buildInfoRow('Date', _formatDate(item.timestamp)),
                    _buildInfoRow('Time', _formatTime(item.timestamp)),
                  ],
                ),
              ),
              24.height,
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: CommonButton(
                      titleText: 'Copy',
                      titleSize: 14,
                      buttonHeight: 48,
                      prefixIcon: const Icon(Icons.copy,
                          color: Colors.white, size: 18),
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: item.content));
                        Get.snackbar(
                          'Copied',
                          'Content copied to clipboard',
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                        );
                      },
                    ),
                  ),
                  12.width,
                  Expanded(
                    child: CommonButton(
                      titleText: 'Share',
                      titleSize: 14,
                      buttonHeight: 48,
                      prefixIcon: const Icon(Icons.share,
                          color: Colors.white, size: 18),
                      onTap: () {
                        Share.share(item.content);
                      },
                    ),
                  ),
                ],
              ),
              12.height,
              if (_canVisit(item.content))
                CommonButton(
                  titleText: 'Visit',
                  titleSize: 14,
                  buttonHeight: 48,
                  prefixIcon: const Icon(Icons.open_in_browser,
                      color: Colors.white, size: 18),
                  onTap: () => _visitContent(item.content),
                ),
              100.height,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CommonText(
            text: '$label: ',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColor.primary,
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  String _formatTime(DateTime date) {
    final hour = date.hour > 12 ? date.hour - 12 : (date.hour == 0 ? 12 : date.hour);
    final period = date.hour >= 12 ? 'PM' : 'AM';
    return '${hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} $period';
  }

  bool _canVisit(String content) {
    final lower = content.toLowerCase().trim();
    return lower.startsWith('http') ||
        lower.startsWith('mailto:') ||
        lower.startsWith('tel:') ||
        lower.startsWith('https://wa.me/');
  }

  void _visitContent(String content) async {
    final Uri? uri = _getLaunchUri(content);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar('Error', 'Could not open this link');
    }
  }

  Uri? _getLaunchUri(String content) {
    final lower = content.toLowerCase().trim();
    try {
      if (lower.startsWith('http')) return Uri.parse(content);
      if (lower.startsWith('mailto:')) return Uri.parse(content);
      if (lower.startsWith('tel:')) return Uri.parse(content);
      if (lower.startsWith('https://wa.me/') || lower.startsWith('http://wa.me/')) {
        return Uri.parse(content);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
