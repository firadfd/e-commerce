import 'package:e_commerce/core/helper/shared_prefarenses_helper.dart';
import 'package:e_commerce/core/routes/app_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInController extends GetxController {
  SharedPreferencesHelper sharedPreferencesHelper = SharedPreferencesHelper();
  final Rx<User?> _firebaseUser = Rx<User?>(null);
  User? get user => _firebaseUser.value;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'https://www.googleapis.com/auth/userinfo.profile'],
  );

  @override
  Future<void> onInit() async {
    await sharedPreferencesHelper.init();
    if (sharedPreferencesHelper.getString("email") != null) {
      Get.offAllNamed(AppRoute.homeScreen);
    }
    _firebaseUser.bindStream(FirebaseAuth.instance.authStateChanges());
    super.onInit();

  }

  Future<void> signInWithGoogle() async {
    try {
      EasyLoading.show(status: 'Signing in...');
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        EasyLoading.dismiss();
        EasyLoading.showInfo('Sign-in canceled by user');
        return;
      }

      // Save info
      sharedPreferencesHelper.setString("name", googleUser.displayName ?? "");
      sharedPreferencesHelper.setString("email", googleUser.email);
      sharedPreferencesHelper.setString("url", googleUser.photoUrl ?? "");

      EasyLoading.dismiss();
      EasyLoading.showSuccess('Signed in successfully');
      await Future.delayed(Duration(milliseconds: 300));
      Get.offAllNamed(AppRoute.homeScreen);
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError('Sign-in failed: $e');
      print(e);
    }
  }

  Future<void> signOut() async {
    try {
      EasyLoading.show(status: 'Signing out...');
      await FirebaseAuth.instance.signOut();
      await _googleSignIn.signOut();
      EasyLoading.dismiss();
      EasyLoading.showSuccess('Signed out successfully');
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError('Sign-out failed: $e');
    }
  }
}
