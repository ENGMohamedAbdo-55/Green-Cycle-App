import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/components/colors.dart';

class TopBarLogin extends StatelessWidget {
  const TopBarLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      decoration: BoxDecoration(
        color: greenColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50.r),
          bottomRight: Radius.circular(50.r),
        ),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text('مرحبا بك', style: AppTextStyles.heading1),
      ),
    );

  }
}
