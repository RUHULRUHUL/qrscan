
import 'package:get/get.dart';
import 'package:qrscan/feature/view/generate_screens/controller/qr_generate_controller.dart';

class DependencyInjection extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>QrGenerateController());
  }

}