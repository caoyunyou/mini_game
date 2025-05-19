import 'package:get/get.dart';
import 'package:mini_game/views/dark_mode/controllers/dark_mode_controller.dart';

class DarkModeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DarkModeController());
  }
}
