import 'package:get/get.dart';

import '../../features/home/controller/home_screen_controller.dart';
import '../../features/signin/controller/sign_in_controller.dart';


class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController(), fenix: true);
    Get.lazyPut(() => HomeScreenController(), fenix: true);
  }
}
