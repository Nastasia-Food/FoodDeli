import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../controllers/location_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocationController>(
      () => LocationController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
