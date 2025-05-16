import 'package:get/get.dart';
import 'package:mini_game/views/guess/controllers/guess_controller.dart';

class GuessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GuessController());
  }
}
