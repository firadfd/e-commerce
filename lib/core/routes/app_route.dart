import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../../features/home/screen/home_screen.dart';
import '../../features/signin/screen/sign_in_screen.dart';

class AppRoute {
  static String signIn = "/SignInScreen";
  static String homeScreen = "/homeScreen";

  static List<GetPage> route = [
    GetPage(
      name: signIn,
      page: () => SignInScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: homeScreen,
      page: () => HomeScreen(),
      transition: Transition.rightToLeft,
    ),

  ];
}
