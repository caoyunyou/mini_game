import 'package:get/get.dart';
import 'package:mini_game/views/theme_setting/controllers/theme_setting_controller.dart';

class ThemeSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ThemeSettingController());
  }
}
