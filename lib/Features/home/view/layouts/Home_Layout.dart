import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_cycle_app/Features/home/ViewModel/HomeScreenCubit.dart';
import 'package:green_cycle_app/Features/home/ViewModel/HomeScreenState.dart';
import 'package:green_cycle_app/core/Services/spacing.dart';
import 'package:green_cycle_app/core/components/colors.dart';
import 'package:green_cycle_app/core/components/topBar.dart';

import '../../../../core/components/text_styles.dart';
import '../../../../core/widgets.dart';

class HomeLayoutScreen extends StatelessWidget {
  const HomeLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenCubit, HomeScreenState>(
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TopBar(),
                verticalSpace(20),
                //  CarouselSlider(
                //                       items: cubit.slidermodel?.data?.sliders
                //                           ?.map((e) => Image(
                //                                 image: NetworkImage('${e.image}'),
                //                                 width: double.infinity,
                //                                 fit: BoxFit.fill,
                //                               ))
                //                           .toList(),
                //                       options: CarouselOptions(
                //                         height: 150,
                //                         viewportFraction: 1.0,
                //                         enableInfiniteScroll: true,
                //                         reverse: false,
                //                         initialPage: 0,
                //                         autoPlay: true,
                //                         autoPlayCurve: Curves.decelerate,
                //                         scrollDirection: Axis.horizontal,
                //                       )),
                Padding(
                  padding: EdgeInsets.only(left: 24.0.w, right: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'الفئات',
                        textAlign: TextAlign.right,
                        style: AppStyles.textStyle24,
                      ),
                      verticalSpace(10),
                      SizedBox(
                        width: 350,
                        height: 40.h,
                        child: ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => InkWell(
                                onTap: () {},
                                child: categoryCard(text1: 'زجاج')),
                            separatorBuilder: (context, index) =>
                                horizontalSpace(5),
                            itemCount: 5),
                      ),
                      verticalSpace(10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'المزيد',
                            style: AppStyles.textStyle14,
                          ),
                          Spacer(),
                          Text(
                            'الإعلانات',
                            textAlign: TextAlign.end,
                            style: AppStyles.textStyle24,
                          ),
                        ],
                      ),
                      GridView.builder(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.only(left: 10, bottom: 20),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {},
                          child: SizedBox(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: MyColors.greenColor,
                                ),
                              ),
                              color: Color.fromARGB(255, 37, 201, 22),
                              child: Padding(
                                padding: EdgeInsets.all(5.0.w),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      height: 80,
                                      'assets/images/onBoarding_images/onBoard1.png',
                                      fit: BoxFit.fill,
                                    ),
                                    verticalSpace(06),
                                    Row(
                                      children: [
                                        Text(
                                          "جديد",
                                          style: AppStyles.textStyle14,
                                          textAlign: TextAlign.end,
                                        ),
                                        Spacer(),
                                        Text(
                                          "text1",
                                          style: AppStyles.textStyle14,
                                          textAlign: TextAlign.end,
                                        ),
                                      ],
                                    ),
                                    verticalSpace(10),
                                    Row(
                                      children: [
                                        Text(
                                          "جديد",
                                          style: AppStyles.textStyle14,
                                          textAlign: TextAlign.end,
                                        ),
                                        Spacer(),
                                        Text(
                                          "text1",
                                          style: AppStyles.textStyle14,
                                          textAlign: TextAlign.end,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        itemCount: 11,
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
