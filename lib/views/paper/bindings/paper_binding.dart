import 'package:get/get.dart';
import 'package:mini_game/views/paper/controllers/paper_controller.dart';

class PaperBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PaperController());
  }
}
