import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_cycle_app/Features/home/ViewModel/cubit/HomeScreenCubit.dart';
import 'package:green_cycle_app/Features/home/ViewModel/cubit/HomeScreenState.dart';

import '../../../../../core/Services/spacing.dart';
import '../../../../../core/colors.dart';
import '../../../../../core/text_styles.dart';

class Image_picker extends StatelessWidget {
  const Image_picker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenCubit, HomeScreenState>(
      builder: (context, state) {
        var cubit = HomeScreenCubit.get(context);

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  " أختر صورة",
                  style: AppStyles.textStyle18,
                ),
                horizontalSpace(100),
                Text(
                  'التقط صوره ',
                  style: AppStyles.textStyle18,
                ),
              ],
            ),
            verticalSpace(10),
            Row(
              children: [
                Container(
                  child: Column(children: [
                    InkWell(
                      onTap: () {
                        cubit.galleryImage();
                      },
                      child: state is PickPhotoSuccess
                          ? Text('')
                          : Container(
                              //select photo
                              width: 160.w,
                              height: 160.h,
                              decoration: BoxDecoration(
                                  color: MyColors.textFieldColor,
                                  borderRadius: BorderRadius.circular(15.r)),
                              child: Center(
                                child: Icon(
                                  Icons.add_a_photo,
                                  size: 45.sp,
                                ),
                              ),
                            ),
                    ),
                    if (cubit.galleryFile != null)
                      Image.file(
                        fit: BoxFit.fill,
                        cubit.galleryFile!,
                        width: 160.w,
                        height: 160.h,
                      )
                  ]),
                ),
                horizontalSpace(20),
                Container(
                  child: Column(children: [
                    InkWell(
                      onTap: () {
                        cubit.cameraImage();
                      },
                      child: state is TakePhotoSuccess
                          ? Text('')
                          : Container(
                              //take a photo
                              width: 160.w,
                              height: 160.h,
                              decoration: BoxDecoration(
                                  color: MyColors.textFieldColor,
                                  borderRadius: BorderRadius.circular(15.r)),
                              child: Center(
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 45.sp,
                                ),
                              ),
                            ),
                    ),
                    if (cubit.cameraFile != null)
                      Image.file(
                        fit: BoxFit.fill,
                        cubit.cameraFile!,
                        width: 160.w,
                        height: 160.h,
                      )
                  ]),
                )
                
              ],
            ),
          ],
        );
      },
    );
  }
}
