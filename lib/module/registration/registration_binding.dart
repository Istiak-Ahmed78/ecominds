import 'package:ecominds/module/login/controller/login_controller.dart';
import 'package:ecominds/module/registration/controller/registration_controller.dart';
import 'package:get/get.dart';

class RegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}
