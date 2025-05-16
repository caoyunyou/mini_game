import 'package:get/get.dart';
import 'package:mini_game/views/guess/controllers/guess_controller.dart';
import 'package:mini_game/views/muyu/controllers/muyu_controller.dart';
import 'package:mini_game/views/navigation/controllers/bottom_nav_controller.dart';
import 'package:mini_game/views/paper/controllers/paper_controller.dart';

class AppNavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomNavController(), fenix: true);
    Get.lazyPut(() => PaperController(), fenix: true);
    Get.lazyPut(() => MuyuController(), fenix: true);
    Get.lazyPut(() => GuessController(), fenix: true);
  }
}
