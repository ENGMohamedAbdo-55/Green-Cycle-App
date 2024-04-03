import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppStyles {
  static  TextStyle textStyle18 = TextStyle(
    fontFamily:'Cairo',
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
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
  static  TextStyle textStyle14 = TextStyle(
    fontFamily:'Cairo',
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  );

  static  TextStyle textStyle16 = TextStyle(
    fontFamily:'Cairo',
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
  );
}