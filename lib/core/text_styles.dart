import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_cycle_app/core/colors.dart';

Color? color;

abstract class AppStyles {
  static TextStyle textStyle18 = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
  );
  static TextStyle greenTextStyle8 = TextStyle(
      fontFamily: 'Cairo',
      fontSize: 8.sp,
      fontWeight: FontWeight.bold,
      color: MyColors.greenColor);
  static TextStyle greenTextStyle10 = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 10.sp,
    fontWeight: FontWeight.w700,
    color: MyColors.greenColor,
  );
  static TextStyle greytextStyle9 = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 9.sp,
    fontWeight: FontWeight.w600,
    color: MyColors.greyColor,
  );
  static TextStyle textStyle20w = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 20.sp,
    fontWeight: FontWeight.normal,
    color: MyColors.whiteColor,
  );
  static TextStyle textStyle20b = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 20.sp,
    fontWeight: FontWeight.normal,
    color: Colors.black
  );
  static TextStyle textStyle20bbold = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: Colors.black
  );

  static TextStyle textStyle30 = TextStyle(
    fontSize: 30.sp,
    fontWeight: FontWeight.w900,
    fontFamily: 'Cairo',
    //letterSpacing: 1.2,
  );
  static TextStyle textStyle11w = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
    color: MyColors.whiteColor,
  );
  static TextStyle textStyle11b = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
    color: MyColors.blackColor,
  );
  static TextStyle textStyle14w = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: MyColors.whiteColor,
  );
  static TextStyle textStyle14b = TextStyle(
      fontFamily: 'Cairo',
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: MyColors.blackColor);

  
  static TextStyle textStyle16b = TextStyle(
      fontFamily: 'Cairo',
      fontSize: 16.sp,
      fontWeight: FontWeight.bold,
      color: Colors.black);
  static TextStyle textStyle16w = TextStyle(
      fontFamily: 'Cairo',
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      color: Colors.white);
  static TextStyle textStyle24 = TextStyle(
      fontFamily: 'Cairo',
      fontSize: 24.sp,
      fontWeight: FontWeight.w500,
      color: Colors.black);
  
  static TextStyle textstyle25w = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 25.sp,
    color: MyColors.whiteColor,
    fontWeight: FontWeight.normal,
  );
  static TextStyle textStyle32 = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 32.sp,
    color: MyColors.whiteColor,
    fontWeight: FontWeight.normal,
  );
}
