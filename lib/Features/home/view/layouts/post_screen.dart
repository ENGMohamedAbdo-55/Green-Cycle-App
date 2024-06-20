import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_cycle_app/Features/home/view/Screens/stepper.dart';
import 'package:green_cycle_app/Features/home/view/layouts/Home_Layout.dart';
import 'package:green_cycle_app/Features/home/view/layouts/user_account.dart';
import 'package:green_cycle_app/core/Services/Navigation.dart';
import 'package:green_cycle_app/core/Services/spacing.dart';
import 'package:green_cycle_app/Features/home/view/components/home/image_picker.dart';
import 'package:green_cycle_app/Features/home/view/components/home/topBar.dart';

import '../components/home/payment_type.dart';
import '../../ViewModel/cubit/HomeScreenCubit.dart';
import '../../ViewModel/cubit/HomeScreenState.dart';
import '../components/home/post_text_fields.dart';
import '../Screens/Home_Screen.dart';

class Post_Screen extends StatelessWidget {
  const Post_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeScreenCubit, HomeScreenState>(
      listener: (context, state) {
        if (state is AddPostSuccessState) {
          print('objectffffffffffahhhhhhhhhhhhhhhhhhaahahashdhsadhhada');
          Navigation.goPush(context, Home_Screen());
        }
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = HomeScreenCubit.get(context);

        return Scaffold(
          body: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Post_Top_Bar(),
              verticalSpace(10),
              Payment_type(),
              verticalSpace(10),
              Padding(
                padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h),
                child: Column(
                  children: [
                    Image_picker(),
                    verticalSpace(10),
                    Post_fields_Screen(),
                  ],
                ),
              ),
            ],
          )),
        );
      },
    );
  }
}
