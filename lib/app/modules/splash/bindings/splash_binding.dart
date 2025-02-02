import 'package:get/get.dart';

import '../../auth/controllers/auth_controller.dart';
import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController(), permanent: true);
    Get.put(AuthController(), permanent: true);
  }
}
