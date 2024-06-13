import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';
import 'text_styles.dart';


class MyDivider1 extends StatelessWidget {
  const MyDivider1({super.key});

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
            style: AppStyles.textStyle11,
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

class MyDivider2 extends StatelessWidget {
  const MyDivider2({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: MyColors.greyColor,
            height: 10.h,
            thickness: 1.1,
          ),
        ),
      ],
    );
  }
}



