import 'package:get/get.dart';
import 'package:qrscan/core/helper/hive_helper.dart';
import 'package:qrscan/core/model/qr_history_item.dart';

class HistoryController extends GetxController {
  RxInt selectedTab = 0.obs;
  RxList<QrHistoryItem> scanHistory = <QrHistoryItem>[].obs;
  RxList<QrHistoryItem> generateHistory = <QrHistoryItem>[].obs;
  RxBool isLoading = false.obs;

  final HiveHelper _hive = HiveHelper();

  @override
  void onInit() {
    super.onInit();
    refreshHistory();
  }

  void refreshHistory() {
    isLoading.value = true;
    scanHistory.value = _hive.getHistoryByType('scan');
    generateHistory.value = _hive.getHistoryByType('generate');
    isLoading.value = false;
  }

  List<QrHistoryItem> get currentList {
    return selectedTab.value == 0 ? scanHistory : generateHistory;
  }

  Future<void> deleteItem(String id) async {
    await _hive.deleteHistory(id);
    refreshHistory();
  }

  Future<void> clearAll() async {
    await _hive.clearAllHistory();
    refreshHistory();
  }
}
