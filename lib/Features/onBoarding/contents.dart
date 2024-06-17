import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/colors.dart';
import '../../core/text_styles.dart';

final PageController boardController = PageController();

class BoardingModel {
  final String image;
  final String body;
  final String title;

  BoardingModel({required this.image, required this.body, required this.title});
}

List<BoardingModel> boarding = [
  BoardingModel(
      image: 'assets/images/onBoarding_images/onBoard1.png',
      title: 'حول المخلفات الي فوائد',
      body: "سوف تربح نقود فوريه مع كل عمليه بيع مخلفات"),
  BoardingModel(
      image: 'assets/images/onBoarding_images/onBoard2.png',
      title: 'جمع المخلفات بسهوله',
      body:
          " يمكنك بسهوله الحفاظ علي بيئتك نظيفه \n          من خلال استخدام تطبيقنا "),
  BoardingModel(
      image: 'assets/images/onBoarding_images/onBoard3.png',
      title: 'يمكنك تحديد موقعك',
      body: "يمكنك بسهوله نشر موقعك لوصول المشتري لك ")
];

Widget buildBoardingItem(context, BoardingModel model) => Column(
      children: [
        Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.infinity,
              decoration: BoxDecoration(
                color: MyColors.lightBlueColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(150.r),
                  bottomRight: Radius.circular(150.r),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height *
                  0.06, // Adjust this value to center the image vertically
              left: MediaQuery.of(context).size.width * 0.50 -
                  100, // Adjust this value to center the image horizontally
              child: Image(
                image: AssetImage(model.image),
                height: 200.h,
                width: 200.w,
              ),
            ),
          ],
        ),
        SizedBox(height: 15.h),
        Text(model.title, style: AppStyles.textStyle30),
        SizedBox(height: 15.h),
        Text(
          model.body,
          style: AppStyles.textStyle14w,
        ),
        SizedBox(height: 30.h),
        Padding(
          padding: const EdgeInsets.all(20.0).h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SmoothPageIndicator(
                controller: boardController,
                count: boarding.length,
                effect: ExpandingDotsEffect(
                  activeDotColor: MyColors.greenColor,
                  dotHeight: 10.h,
                  dotWidth: 10.w,
                ),
              ),
            ],
          ),
        ),
      ],
    );
