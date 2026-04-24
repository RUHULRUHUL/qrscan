import 'package:flutter/material.dart';
import 'package:qrscan/core/constant/app_color.dart';
import 'package:qrscan/core/constant/app_string.dart';
import 'package:qrscan/core/constant/extentions.dart';
import 'package:qrscan/feature/component/common_appbar.dart';
import 'package:qrscan/feature/view/history_screen/widgets/history_card.dart';
import 'package:qrscan/feature/view/history_screen/widgets/history_tab.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black33,
      appBar: const CommonAppBar(title: AppString.history),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
        child: Column(
          children: [
            //================================history tab
            const HistoryTab(),
            20.height,

            //====================================history body
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                spacing: 20,
                children: [
                  ...List.generate(20, (index) {
                    return const HistoryCard();
                  }),
                  150.height,
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
