import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_cycle_app/core/colors.dart';

abstract class AppStyles {
  static  TextStyle textStyle18 = TextStyle(
    fontFamily:'Cairo',
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
  );
  static  TextStyle greenTextStyle8 = TextStyle(
    fontFamily:'Cairo',
    fontSize: 8.sp,
    fontWeight: FontWeight.bold,
    color: MyColors.greenColor

  );
  static  TextStyle greytextStyle9 = TextStyle(
    fontFamily:'Cairo',
    fontSize: 9.sp,
    fontWeight: FontWeight.w600,
    color: MyColors.greyColor,
  );
  static  TextStyle textStyle20 = TextStyle(
    fontFamily:'Cairo',
    fontSize: 20.sp,
    fontWeight: FontWeight.normal,
  );

  static  TextStyle textStyle30 = TextStyle(
    fontSize: 30.sp,
    fontWeight: FontWeight.w900,
    fontFamily:'Cairo',
    //letterSpacing: 1.2,
  );
  static  TextStyle textStyle11 = TextStyle(
    fontFamily:'Cairo',
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
  );
  static  TextStyle textStyle14 = TextStyle(
    fontFamily:'Cairo',
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  );

  static  TextStyle textStyle16 = TextStyle(
    fontFamily:'Cairo',
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
        color: Colors.white

  );
  static  TextStyle textStyle16w = TextStyle(
    fontFamily:'Cairo',
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: Colors.white
  );
  static  TextStyle textStyle24 = TextStyle(
    fontFamily:'Cairo',
    fontSize: 24.sp,
    fontWeight: FontWeight.w500,color: Colors.black
  );
  static  TextStyle heading20 = TextStyle(
    fontFamily:'Cairo',
    fontSize: 20.sp,
    color: MyColors.whiteColor,
    fontWeight: FontWeight.normal,
  );
  static  TextStyle heading25 = TextStyle(
    fontFamily:'Cairo',
    fontSize: 25.sp,
    color: MyColors.whiteColor,
    fontWeight: FontWeight.normal,
  );
  static  TextStyle textStyle32 = TextStyle(
    fontFamily:'Cairo',
    fontSize: 32.sp,
    color: MyColors.whiteColor,
    fontWeight: FontWeight.normal,
  );
}