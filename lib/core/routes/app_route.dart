import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../../features/signin/screen/sign_in_screen.dart';

class AppRoute {
  static String homeScreen = "/homeScreen";
  static String signIn = "/SignInScreen";

  static List<GetPage> route = [
    GetPage(
      name: signIn,
      page: () => SignInScreen(),
      transition: Transition.rightToLeft,
    ),

  ];
}
