import 'package:ecominds/module/level_control/controller/level_controller.dart';
import 'package:ecominds/module/mcq/controller/mcq_controller.dart';
import 'package:get/get.dart';

class LevelControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => McqController());
    Get.lazyPut(() => LavelController());
  }
}
