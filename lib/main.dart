import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'app.dart';
import 'core/binding/app_binding.dart';
import 'core/helper/shared_prefarenses_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey =
      "pk_test_51RLGHnHDdO1S05AmznW8b9jMIHZRTCgr04fLh7EuKXhz7TX5H8f8SSzJybrqzPGKU7GXznI9kVs6FhJ6inx6Aux200ydlNiWGk";

  await SharedPreferencesHelper().init();
  AppBinding().dependencies();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  runApp(MyApp());
}
