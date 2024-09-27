import 'package:ecominds/module/login/controller/login_controller.dart';
import 'package:ecominds/module/mcq/controller/mcq_controller.dart';
import 'package:ecominds/module/registration/controller/registration_controller.dart';
import 'package:ecominds/module/splash_screen/controller/splash_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => RegisterController());
    Get.lazyPut(() => McqController());
  }
}
