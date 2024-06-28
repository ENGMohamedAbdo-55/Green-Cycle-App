import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Screens/search_screen.dart';

import '../../../../../core/Services/Navigation.dart';
import '../../../../../core/Services/spacing.dart';
import '../../../../../core/colors.dart';
import '../../../../../core/text_styles.dart';
import '../../../../../core/widgets.dart';

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
                homeAppBar(color: Colors.black, icon: const Icon(Icons.add_a_photo)),
                Spacer(),
                Text(
                  'كاربج',
                  style: AppStyles.textStyle32,
                ),
                Spacer(),
                homeAppBar(color: MyColors.blackColor, icon: const Icon(Icons.report))
              ],
            ),
            verticalSpace(16),
            Row(
              children: [
                homeAppBar(color: Colors.black, icon: Icon(Icons.tune)),
                horizontalSpace(16),
                Expanded(
                  child: InkWell(
                    onTap: () => Navigation.goPush(context, Search_Screen()),
                    child: Container(
                      height: 40.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Color.fromARGB(255, 224, 219, 219)),
                      child: ListTile(
                        trailing: Icon(
                          Icons.search,
                          size: 35.sp,
                        ),
                        title: Text(
                          'ما الذي تبحث عنه ؟',
                          textAlign: TextAlign.right,
                          style: AppStyles.textStyle14b,
                        ),
                      ),
                    ),
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

class Post_Top_Bar extends StatelessWidget {
  const Post_Top_Bar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130.h,
      decoration: BoxDecoration(
        color: MyColors.greenColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50.r),
          bottomRight: Radius.circular(50.r),
        ),
      ),
      child: Padding(
          padding: EdgeInsets.only(right: 10.0.w, left: 30.w, top: 32.h),
          child: Center(
              child: ListTile(
            leading: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 30.sp,
            ),
            title: Text(
              'بيانات الإعلان ',
              style: AppStyles.textStyle32,
            ),
          ))),
    );
  }
}
