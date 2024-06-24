import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../auth/login/screen/login_screen.dart';
import 'contents.dart';
import '../home/view/components/navigation_const.dart';

import '../../core/Services/local/secure_keys.dart';
import '../../core/Services/local/secure_storage.dart';
import '../../core/colors.dart';

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
                      SecureStorage().setSecureData(SecureKeys.hasSeenOnboarding ,'true');

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

