import 'package:ecominds/module/home_page/controller/home_controller.dart';
import 'package:ecominds/module/level_control/controller/level_controller.dart';
import 'package:ecominds/module/login/controller/login_controller.dart';
import 'package:ecominds/module/mcq/controller/mcq_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(McqController());
    Get.lazyPut(() => LavelController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => LoginController());
  }
}
