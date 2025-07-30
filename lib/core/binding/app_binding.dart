import 'package:get/get.dart';

import '../../features/signin/screen/sign_in_controller.dart';


class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController(), fenix: true);
  }
}
