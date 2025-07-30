import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/features/signin/screen/sign_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final SignInController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            controller.signInWithGoogle();
          },
          child: Text('Sign in with Google',style: GoogleFonts.andika(
            fontSize: 18.spMin,
            fontWeight: FontWeight.w500,
            color: AppColors.textExtraLightGray
          ),),
        ),
      ),
    );
  }
}
