import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Size preferredSize;
  final String name;
  final String email;
  final String imageUrl;

  HomeAppBar({
    Key? key,
    required this.name,
    required this.email,
    required this.imageUrl,
  }) : preferredSize = Size.fromHeight(56.h),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: AppBar(
        centerTitle: false,
        scrolledUnderElevation: 0,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(30.r),
          child: Image.network(
            imageUrl,
            width: 30.w,
            height: 30.h,
            fit: BoxFit.cover,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Hi, $name",
                  style: GoogleFonts.andika(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                Text(
                  email,
                  style: GoogleFonts.andika(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
