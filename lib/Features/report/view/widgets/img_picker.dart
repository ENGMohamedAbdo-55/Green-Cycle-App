import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_cycle_app/Features/report/view%20model/cubit/report_cubit.dart';

import '../../../../core/colors.dart';
import '../../../../core/text_styles.dart';

class imgBicker extends StatelessWidget {
  const imgBicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        width: double.infinity,
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: MyColors.backGroundGrey,
        ), // Adjust as desired),

        child: BlocBuilder<ReportCubit, ReportState>(
          builder: (context, state) {
            var cubit = ReportCubit.get(context);
            if (state is TakePhotoInitial) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: cubit.cameraImage(),
                      child: Image.asset(
                          "assets/images/report/photo_camera 1.png")),
                  Text(
                    "فتح كاميرا",
                    style: AppStyles.textStyle30,
                  ),
                ],
              );
            } else if (state is TakePhotoSuccess) {
              return Image.network(
                  fit: BoxFit.fill, ReportCubit.get(context).reportCameraUrl!);
            } else if (state is TakePhotoLoading) {
              return CircularProgressIndicator();
            } else {
              return Center(
                child: Text(
                  "Something went wrong",
                  style: AppStyles.textStyle30,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
