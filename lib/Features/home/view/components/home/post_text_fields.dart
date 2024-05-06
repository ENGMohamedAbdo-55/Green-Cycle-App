import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_cycle_app/Features/home/ViewModel/cubit/HomeScreenCubit.dart';
import 'package:green_cycle_app/Features/home/ViewModel/cubit/HomeScreenState.dart';

import '../../../../../core/Services/spacing.dart';
import '../../../../../core/colors.dart';
import '../../../../../core/text_styles.dart';
import '../../../../../core/textfield.dart';
import '../../../../../core/widgets.dart';

class Post_fields_Screen extends StatelessWidget {
  const Post_fields_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenCubit, HomeScreenState>(
      builder: (context, state) {
        var cubit = HomeScreenCubit.get(context);

        return Form(
          key: cubit.AddPostKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              postText(text: 'كمية الروبابيكيا'),
              verticalSpace(10),
              PostTxtField(
                controller: cubit.titleController,
                hintText: 'ادخل الكمية',
                suffixIcon: Icon(Icons.shopping_bag),
              ),
              verticalSpace(15),
              postText(text: 'الوصف'),
              verticalSpace(10),
              PostTxtField(
                controller: cubit.descriptionController,
                hintText: 'ادخل النص',
                height: 150.h,
                lines: 5,
                suffixIcon: Icon(Icons.label_important_rounded),
              ),
              verticalSpace(15),
              postText(text: 'موقع المعاينة'),
              verticalSpace(10),
              // PostTxtField(
              //   controller: cubit.locationController,
              //   hintText: 'اختار الموقع',
              //   prefixIcon: Icon(
              //     Icons.location_searching_outlined,
              //     color: MyColors.greenColor,
              //   ),
              //   suffixIcon: Icon(Icons.location_on),
              // ),
              verticalSpace(15),
              postText(text: 'وقت المعاينة'),
              verticalSpace(10),
              DateTime_TxtField(
                controller: cubit.timeController,
                hintText: 'ادخل الوقت',
                suffixIcon: Icon(Icons.watch_later_sharp),
                prefixIcon: Icon(Icons.arrow_downward_rounded),
                onTap: () {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  ).then((value) {
                    if (value != null) {
                      final selectedTime = DateTime(
                        value.hour,
                        value.minute,
                      );
                      cubit.timeController.text = selectedTime.toString();
                    }
                  });
                },
              ),
              verticalSpace(15),
              postText(text: 'تاريخ المعاينة'),
              verticalSpace(10),
              PostTxtField(
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2027),
                  ).then((value) {
                    if (value != null) {
                      final selectedDate =
                          DateTime(value.year, value.month, value.day);
                      cubit.dateController.text = selectedDate.toString();
                    }
                  });
                },
                controller: cubit.dateController,
                hintText: 'ادخل التاريخ',
                suffixIcon: Icon(Icons.calendar_month_outlined),
                prefixIcon: Icon(Icons.arrow_downward_rounded),
              ),
              verticalSpace(10),
              SizedBox(
                width: double.infinity,
                height: 40.h,
                child: ElevatedButton(
                    onPressed: () {
                      if (cubit.AddPostKey.currentState!.validate()) {
                        cubit.addPostToFireBase();
                        //cubit.addtasks();
                      }
                    },
                    child: Text(
                      'نشر الإعلان',
                      style: AppStyles.textStyle16,
                    ),
                    style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(color: MyColors.whiteColor),
                        backgroundColor: MyColors.greenColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r)))),
              ),
              verticalSpace(60)
            ],
          ),
        );
      },
    );
  }
}
