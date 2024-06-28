import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../ViewModel/cubit/HomeScreenCubit.dart';
import '../../../ViewModel/cubit/HomeScreenState.dart';

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
                IconButton(
                  onPressed: () {
                    cubit.galleryImage();
                  },
                  icon: Icon(
                    Icons.photo_size_select_actual_rounded,
                    size: 40.sp,
                    color: MyColors.greenColor,
                  ),
                ),
                Text(
                  " أختر صورة",
                  style: AppStyles.textStyle18,
                ),
                horizontalSpace(50.w),
                IconButton(
                  onPressed: () {
                    cubit.cameraImage();
                  },
                  icon: Icon(
                    Icons.camera_alt,
                    size: 40.sp,
                    color: MyColors.greenColor,
                  ),
                ),
                Text(
                  'التقط صوره ',
                  style: AppStyles.textStyle18,
                ),
              ],
            ),
            verticalSpace(10),
            Row(
              children: [
                if (cubit.galleryUrl != null)
                  state is PickPhotoLoading
                      ? CircularProgressIndicator.adaptive()
                      : Image.network(
                          fit: BoxFit.fill,
                          cubit.galleryUrl!,
                          width: 160.w,
                          height: 160.h,
                        ),
                horizontalSpace(20),
                if (cubit.cameraUrl != null)
                  state is TakePhotoLoading
                      ? CircularProgressIndicator.adaptive()
                      : Image.network(
                          fit: BoxFit.fill,
                          cubit.cameraUrl!,
                          width: 160.w,
                          height: 160.h,
                        )
              ],
            ),
          ],
        );
      },
    );
  }
}
