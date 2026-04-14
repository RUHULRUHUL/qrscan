import 'package:get/get.dart';
import 'package:qrscan/core/constant/app_icon.dart';
import 'package:qrscan/core/constant/app_string.dart';

class QrGenerateController extends GetxController{
  

 List qrItem = [
  {"title":AppString.text,"icon":AppIcon.text},
  {"title":AppString.website,"icon":AppIcon.web},
  {"title":AppString.wifi,"icon":AppIcon.wifi},
  {"title":AppString.event,"icon":AppIcon.event},
  {"title":AppString.contact,"icon":AppIcon.contact},
  {"title":AppString.business,"icon":AppIcon.buissness},
  {"title":AppString.location,"icon":AppIcon.location},
  {"title":AppString.whatsapp,"icon":AppIcon.whatsapp},
  {"title":AppString.email,"icon":AppIcon.email},
  {"title":AppString.twitter,"icon":AppIcon.twitter},
  {"title":AppString.instagram,"icon":AppIcon.instagram},
  {"title":AppString.telephone,"icon":AppIcon.phone},
 ];
}