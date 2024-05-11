import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
              borderRadius: BorderRadius.circular(10.r),
              side: BorderSide(
                width: 0.5,
                color: MyColors.greenColor,
              ),
            ),
            color: MyColors.whiteColor,
            child: Column(
              textDirection: TextDirection.rtl,
              children: [
                Column(children: [
                  if (posts?.cameraUrl != "none")
                    Image.network(
                      posts?.cameraUrl ??
                          posts?.galleryUrl ??
                          "${Icon(
                            Icons
                                .signal_wifi_statusbar_connected_no_internet_4_outlined,
                            size: 140.sp,
                          )}",
                      // 'assets/images/onBoarding_images/onBoard1.png',
                      height: 160.h, width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                ]),
                Padding(
                  padding:
                      EdgeInsets.only(left: 10.0.w, right: 10.w, top: 10.h),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "جديد",
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.4)),
                            textAlign: TextAlign.end,
                          ),
                          Spacer(),
                          SizedBox(
                            width: 100.w,
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              posts?.title ?? "text1",
                              style: AppStyles.textStyle16b,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(10),
                      /*wrap*/ Row(
                        children: [
                          Spacer(),
                          SizedBox(
                            height: 30,
                            width: 120.w,
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              posts?.description ?? "text1",
                              style: AppStyles.textStyle18,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
