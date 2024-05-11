import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_cycle_app/Features/auth/register/register_screen.dart';
import 'package:green_cycle_app/Features/home/view/components/navigation_const.dart';

import '../../../../core/colors.dart';
import '../../../../core/text_styles.dart';
import '../cubit/login_cubit.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({Key? key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: MyColors.greyColor,
            height: 10.h,
            thickness: 1.5,
            indent: 20,
            endIndent: 20,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Text(
            'او',
            style: AppStyles.textStyle11b,
          ),
        ),
        Expanded(
          child: Divider(
            color: MyColors.greyColor,
            height: 10.h,
            thickness: 1.5,
            indent: 20,
            endIndent: 20,

          ),
        ),
      ],
    );
  }
}

class GoogleAndFace extends StatelessWidget {
  const GoogleAndFace({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = LoginCubit.get(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: (){
            cubit.signInWithGoogle();
          },
          child: Container(
            alignment: Alignment.centerRight,
            height: 50.h,
            width: 100.w,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: MyColors.greenColor,
              ),
            ),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                    'التسجيل بجوجل',
                    style: AppStyles.greenTextStyle8
                ),
                Image(image: AssetImage('assets/images/logo/google.png'),
                  width: 30.w,
                  height: 50.h,

                ),
              ],
            ),

          ),
        ),
        SizedBox(width: 50.w),
        // GestureDetector(
        //   onTap: (){
        //     cubit.signInWithFacebook();
        //   },
        //   child: Container(
        //     alignment: Alignment.centerRight,
        //     height: 50.h,
        //     width: 100.w,
        //     decoration: BoxDecoration(
        //       color: Colors.transparent,
        //       borderRadius: BorderRadius.circular(10.r),
        //       border: Border.all(
        //         color: MyColors.greenColor,
        //       ),
        //     ),
        //     child:Row(
        //       mainAxisAlignment: MainAxisAlignment.end,
        //       children: [
        //         Text(
        //           'التسجيل بفيس بوك',
        //           style: AppStyles.greenTextStyle8
        //         ),
        //         Icon(
        //               Icons.facebook,
        //               size: 25.sp,
        //               color: MyColors.greenColor,
        //               ),
        //       ],
        //     ),

        //   ),
        // ),

      ],
    );
  }
}

