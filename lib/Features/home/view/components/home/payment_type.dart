import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../ViewModel/cubit/HomeScreenCubit.dart';
import '../../../ViewModel/cubit/HomeScreenState.dart';
import '../../../../../core/Services/spacing.dart';

import '../../../../../core/colors.dart';
import '../../../../../core/text_styles.dart';

class Payment_type extends StatelessWidget {
  const Payment_type({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenCubit, HomeScreenState>(
      builder: (context, state) {
        var cubit = HomeScreenCubit.get(context);

        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 160.w,
              height: 70.h,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 82, 80, 80),
                  borderRadius: BorderRadius.circular(20.r)),
              child: RadioMenuButton(
                trailingIcon: Icon(
                  Icons.change_circle_outlined,
                  color: Color.fromARGB(255, 138, 129, 129),
                  size: 20.sp,
                ),
                value: 0,
                groupValue: cubit.groupValue,
                onChanged: (value) {
                  cubit.changeGroupValue();
                },
                child: Text(
                  textAlign: TextAlign.end,
                  'تحويل بنكي',
                  style: TextStyle(
                      color: Color.fromARGB(255, 138, 129, 129),
                      fontSize: 16.sp),
                ),
              ),
            ),
            horizontalSpace(25),
            Container(
              width: 160.w,
              height: 70.h,
              decoration: BoxDecoration(
                  color: MyColors.greenColor,
                  borderRadius: BorderRadius.circular(20.r)),
              child: RadioMenuButton(
                trailingIcon: Icon(
                  Icons.credit_card,
                  size: 20.sp,
                  color: Colors.white,
                ),
                style: const ButtonStyle(alignment: Alignment.center),
                value: 1,
                groupValue: cubit.groupValue,
                child: Text(
                  textAlign: TextAlign.end,
                  'كاش',
                  style: AppStyles.textStyle16w,
                ),
                onChanged: (value) {
                  cubit.changeGroupValue();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
