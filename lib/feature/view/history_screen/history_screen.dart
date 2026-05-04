import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrscan/core/constant/app_color.dart';
import 'package:qrscan/core/constant/app_string.dart';
import 'package:qrscan/core/constant/extentions.dart';
import 'package:qrscan/feature/component/common_appbar.dart';
import 'package:qrscan/feature/view/history_screen/controller/history_controller.dart';
import 'package:qrscan/feature/view/history_screen/widgets/history_card.dart';
import 'package:qrscan/feature/view/history_screen/widgets/history_tab.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HistoryController controller = Get.find<HistoryController>();
    return Scaffold(
      backgroundColor: AppColor.black33,
      appBar:  CommonAppBar(title: AppString.history),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
        child: Column(
          children: [
            const HistoryTab(),
            20.height,
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColor.primary),
                  );
                }
                if (controller.currentList.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.history,
                          size: 60,
                          color: Colors.grey.shade600,
                        ),
                        16.height,
                        const Text(
                          'No history yet',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: controller.currentList.length,
                  padding: const EdgeInsets.only(bottom: 150),
                  itemBuilder: (context, index) {
                    final item = controller.currentList[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: HistoryCard(
                        item: item,
                        onDelete: () => controller.deleteItem(item.id),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
