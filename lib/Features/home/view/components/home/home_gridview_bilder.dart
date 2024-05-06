import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_cycle_app/Features/home/ViewModel/cubit/HomeScreenCubit.dart';
import 'package:green_cycle_app/Features/home/ViewModel/cubit/HomeScreenState.dart';

import '../../../../../core/colors.dart';
import '../../../../../core/text_styles.dart';
import '../../../Model/post_model.dart';
import '../../../../../core/Services/spacing.dart';

class Home_Builder extends StatelessWidget {
  PostModelFireBase? posts;
  Home_Builder({required this.posts, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenCubit, HomeScreenState>(
      builder: (context, state) {
        var cubit = HomeScreenCubit.get(context);
        return SizedBox(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: MyColors.greenColor,
              ),
            ),
            color: MyColors.whiteColor,
            child: Padding(
              padding: EdgeInsets.all(5.0.w),
              child: Column(
                children: [
                  Image.asset(
                    height: 80,
                    'assets/images/onBoarding_images/onBoard1.png',
                    fit: BoxFit.fill,
                  ),
                  verticalSpace(06),
                  Row(
                    children: [
                      Text(
                        "جديد",
                        style: AppStyles.textStyle14,
                        textAlign: TextAlign.end,
                      ),
                      Spacer(),
                      Text(
                        posts?.title ?? "text1",
                        style: AppStyles.textStyle14,
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                  verticalSpace(10),
                  Row(
                    children: [
                      Text(
                        "جديد",
                        style: AppStyles.textStyle14,
                        textAlign: TextAlign.end,
                      ),
                      Spacer(),
                      Text(
                        posts?.description ?? "text1",
                        style: AppStyles.textStyle14,
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
