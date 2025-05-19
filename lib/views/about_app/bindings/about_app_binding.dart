import 'package:get/get.dart';
import 'package:mini_game/views/about_app/controllers/about_app_controller.dart';

class AboutAppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AboutAppController());
  }
}
