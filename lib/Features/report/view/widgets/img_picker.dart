import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_cycle_app/Features/report/view%20model/cubit/report_cubit.dart';

import '../../../../core/Services/spacing.dart';
import '../../../../core/colors.dart';
import '../../../../core/text_styles.dart';

class ImagePicker extends StatelessWidget {
  const ImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportCubit, ReportState>(
      builder: (context, state) {
        var cubit = ReportCubit.get(context);

        return Column(
          children: [
            Row(
              mainAxisAlignment:MainAxisAlignment.center,
             
              children: [
         
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
               
              ],
            ),
            verticalSpace(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
         
                if (cubit.reportCameraUrl != null)
                  state is TakePhotoLoading
                      ? CircularProgressIndicator.adaptive()
                      : Container(
        width: 250.w,
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(19.0),
          color: MyColors.backGroundGrey,
          
                        ), child:Image.network(
                          fit: BoxFit.fill,
                          cubit.reportCameraUrl!,
                          //width: 160.w,
                          //height: 160.h,
                        ),), //
              ],
            ),
          ],
        );
      },
    );
  }
}
// Container(
//         width: double.infinity,
//         height: 180,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(16.0),
//           color: MyColors.backGroundGrey,
          
//                         ), child:Image.network(
//                           fit: BoxFit.fill,
//                           cubit.reportCameraUrl!,
//                           width: 160.w,
//                           height: 160.h,
//                         ),), // Adjust