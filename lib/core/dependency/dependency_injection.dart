
import 'package:get/get.dart';
import 'package:qrscan/feature/view/generate_screens/controller/qr_generate_controller.dart';
import 'package:qrscan/feature/view/history_screen/controller/history_controller.dart';
import 'package:qrscan/feature/view/scanner_screen/controller/scanner_controller.dart';

class DependencyInjection extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>QrGenerateController());
    Get.lazyPut(()=>HistoryController());
    Get.lazyPut(()=>ScannerController());
  }

}