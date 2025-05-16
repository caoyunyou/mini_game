import 'package:get/get.dart';
import 'package:mini_game/views/muyu/controllers/muyu_controller.dart';

class MuyuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MuyuController(), fenix: true);
  }
}
