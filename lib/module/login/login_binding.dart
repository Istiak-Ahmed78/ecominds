import 'package:ecominds/module/login/controller/login_controller.dart';
import 'package:ecominds/module/registration/controller/registration_controller.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController());
    Get.put(LoginController());
  }
}
