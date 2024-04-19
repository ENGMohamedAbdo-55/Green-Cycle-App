import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_cycle_app/core/components/colors.dart';

import '../Services/spacing.dart';
import '../widgets.dart';
import 'text_styles.dart';

class TopBar extends StatelessWidget {
  final double? buttonHeight;
  const TopBar({this.buttonHeight, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: buttonHeight ?? 177.h,
      decoration: BoxDecoration(
        color: MyColors.greenColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50.r),
          bottomRight: Radius.circular(50.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(right: 24.0.w, left: 24.w, top: 32.h),
        child: Column(
          children: [
            horizontalSpace(50),
            Row(
              children: [
                homeAppBar(
                    color: Colors.black, icon: Icon(Icons.notifications)),
                Spacer(),
                Text(
                  'كاربج',
                  style: AppStyles.homeHeader,
                ),
                Spacer(),
                homeAppBar(
                    color: MyColors.blackColor, icon: Icon(Icons.filter_3))
              ],
            ),
            verticalSpace(16),
            Row(
              children: [
                homeAppBar(color: Colors.black, icon: Icon(Icons.tune)),
                horizontalSpace(16),
                Container(
                  width: 250.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 224, 219, 219)),
                  child: ListTile(
                    trailing: Icon(
                      Icons.search,
                      size: 35.sp,
                    ),
                    title: Text(
                      'ما الذي تبحث عنه ؟',
                      textAlign: TextAlign.right,
                      style: AppStyles.textStyle14,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
