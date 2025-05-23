import 'package:get/get.dart';
import 'package:mini_game/views/language_setting/controllers/language_setting_controller.dart';

class LanguageSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LanguageSettingController());
  }
}
