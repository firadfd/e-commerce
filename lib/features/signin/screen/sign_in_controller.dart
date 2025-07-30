import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInController extends GetxController {
  final Rx<User?> _firebaseUser = Rx<User?>(null);

  User? get user => _firebaseUser.value;

  final RxString _displayName = 'Guest'.obs;

  String get displayName => _displayName.value;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'https://www.googleapis.com/auth/userinfo.profile'],
  );

  @override
  void onInit() {
    super.onInit();

    _firebaseUser.bindStream(FirebaseAuth.instance.authStateChanges());

    ever(_firebaseUser, (User? user) {
      _displayName.value = user?.displayName ?? 'Guest';
    });
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        Get.snackbar('Info', 'Sign-in canceled by user');
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
      _displayName.value = googleUser.displayName ?? 'Guest';
      Get.snackbar('Success', 'Signed in as ${_displayName.value}');
    } catch (e) {
      Get.snackbar('Error', 'Failed to sign in with Google: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      await _googleSignIn.signOut();
      _displayName.value = 'Guest';
      Get.snackbar('Success', 'Signed out successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to sign out: $e');
    }
  }
}
