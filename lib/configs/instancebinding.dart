import 'package:get/get.dart';
import 'package:scanstonks/controllers/main_controller.dart';

class InstanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MainController>(MainController(), permanent: true);
    // Get.put<CheckInternetController>(CheckInternetController());
  }
}
