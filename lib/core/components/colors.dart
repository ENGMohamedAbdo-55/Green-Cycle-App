import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Color greenColor =const Color(0xFF078D1A);
Color whiteColor =const Color(0xFFFFFFFF);
Color greyColor=const Color(0xFF939393);

class AppTextStyles {
  static  TextStyle heading1 = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    color: whiteColor,
  );

  static  TextStyle heading2 = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static  TextStyle bodyText = TextStyle(
    fontSize: 16.sp,
    color: Colors.black,
  );
  static  TextStyle smallText = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.bold,
    color: greyColor,
  );

}
