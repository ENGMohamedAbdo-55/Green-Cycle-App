import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_cycle_app/Features/auth/login/screen/login_screen.dart';
import 'package:green_cycle_app/Features/onBoarding/contents.dart';
import 'package:green_cycle_app/core/components/colors.dart';
import 'package:green_cycle_app/core/components/navigation_const.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: boardController,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        buildBoardingItem(context,boarding[index]),
                    itemCount: boarding.length,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  shape: const CircleBorder(),
                  onPressed: () {
                    if (boardController.page == boarding.length - 1) {
                      navigateAndFinish(context, const LoginScreen());

                    } else {
                      boardController.nextPage(
                        duration: const Duration(microseconds: 800),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  backgroundColor: MyColors.greenColor,
                  child: Icon(
                    Icons.arrow_forward,
                    color: MyColors.whiteColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
