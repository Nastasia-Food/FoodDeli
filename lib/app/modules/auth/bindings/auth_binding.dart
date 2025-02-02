import 'package:get/get.dart';
import '../../home/controllers/home_controller.dart';
import '../../home/controllers/location_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../../splash/controllers/splash_controller.dart';
import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(SplashController());
    Get.put(HomeController());
    Get.put(ProfileController());
    Get.put(LocationController());
  }
}
