import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_cycle_app/core/Services/spacing.dart';
import 'package:green_cycle_app/core/text_styles.dart';

import 'colors.dart';

homeAppBar({Icon? icon, Color? color, double? width}) => Container(
      width: width?.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 224, 219, 219)),
      child: IconButton(
        onPressed: () {},
        icon: icon ??
            Icon(
              Icons.notifications,
              color: color,
            ),
      ),
    );
categoryCard({
  required String text1,
}) =>
    SizedBox(
      height: 40,
      width: 64,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: MyColors.greenColor,
          ),
        ),
        color: Color.fromARGB(255, 255, 255, 255),
        child: Padding(
            padding: EdgeInsets.all(5.0.w),
            child: Text(
              text1,
              style: AppStyles.textStyle14,
              textAlign: TextAlign.center,
            )),
      ),
    );

itemCard({
  String? text1,
  String? text2,
  String? text3,
  dynamic text4,
  String? image,
  Icon? icon,
  final VoidCallback? onPressed1,
  final VoidCallback? onPressed2,
}) =>
    SizedBox(
      height: 200,
      width: 200,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(
            color: Color.fromARGB(255, 205, 214, 231),
          ),
        ),
        color: Color.fromARGB(255, 213, 231, 236),
        child: Padding(
          padding: EdgeInsets.all(5.0.w),
          child: Row(
            children: [
              Container(
                width: 100,
                height: 130,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Image.asset(
                  image ?? 'sssss',
                  fit: BoxFit.fill,
                ),
              ),
              verticalSpace(12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'جديد',
                        style: AppStyles.textStyle14,
                      ),
                      Spacer(),
                      Text(
                        '10 طن مستعمل',
                        style: AppStyles.textStyle14,
                      ),
                    ],
                  ),
                  verticalSpace(10),
                  Row(
                    children: [
                      Text(
                        'جديد',
                        style: AppStyles.textStyle14,
                      ),
                      Spacer(),
                      Text(
                        '10 طن مستعمل',
                        style: AppStyles.textStyle14,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
Widget postText({required String text}) => Text(
      text,
      style: AppStyles.textStyle18,
    );

Widget custombutton({
  required Color color,
  required Color fontcolor,
  required String text,
  double? w,
  double? h,
  double? size,
}) =>
    Container(
      width: w ?? 350.w,
      height: h ?? 50.h,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(50.r)),
      child: Center(
        child: Text(
          '$text',
          style: TextStyle(fontSize: size ?? 20.sp, color: fontcolor),
        ),
      ),
    );
