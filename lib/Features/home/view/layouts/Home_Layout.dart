import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../ViewModel/cubit/HomeScreenCubit.dart';
import '../../ViewModel/cubit/HomeScreenState.dart';
import '../Screens/details_screen.dart';
import '../../../../core/Services/Navigation.dart';
import '../../../../core/Services/spacing.dart';
import '../components/home/home_gridview_bilder.dart';
import '../components/home/topBar.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/text_styles.dart';
import '../../../../core/widgets.dart';
import '../Screens/all_posts.dart';
import '../Screens/sidebar_menu.dart';

class HomeLayoutScreen extends StatelessWidget {
  const HomeLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: HomeScreenCubit.get(context)..getAllPostsFromFireBase(),
      child: BlocBuilder<HomeScreenCubit, HomeScreenState>(
        builder: (context, state) {
          var cubit = HomeScreenCubit.get(context);
          return Scaffold(
            // key: ,
            endDrawer: MyDrawer(),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TopBar(),
                  verticalSpace(20),
                  CarouselSlider(
                    items: [
                      'assets/images/onBoarding_images/onBoard3.png',
                      'assets/images/onBoarding_images/onBoard3.png',
                      'assets/images/onBoarding_images/onBoard3.png'
                    ]
                        .map((e) => Container(
                              width: 320.w,
                              padding: EdgeInsets.only(left: 30.w, right: 30.w),
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 243, 242, 238),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Image.asset(
                                '$e',
                                fit: BoxFit.fill,
                              ),
                            ))
                        .toList(),
                    options: CarouselOptions(
                      onPageChanged: (index, reason) => cubit.activeindex,
                      enlargeCenterPage: true,
                      height: 200,
                      viewportFraction: 1.0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      initialPage: 0,
                      autoPlay: true,
                      autoPlayCurve: Curves.decelerate,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  (cubit.PostsFireBase ?? []).isEmpty
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Lottie.network(
                                'https://assets5.lottiefiles.com/packages/lf20_rzjlioaj.json',
                                height: 200.h,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                'لا يوجد شئ حتي الان! ...',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(left: 20.w, right: 20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              verticalSpace(10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      return Navigation.goPush(
                                          context, All_Posts_Screen());
                                    },
                                    child: Text(
                                      'المزيد',
                                      style: AppStyles.textStyle20b,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    'الإعلانات',
                                    textAlign: TextAlign.end,
                                    style: AppStyles.textStyle24,
                                  ),
                                ],
                              ),
                              GridView.count(
                                physics: NeverScrollableScrollPhysics(),
                                crossAxisCount: 2,
                                shrinkWrap: true,
                                mainAxisSpacing: 10.w,
                                crossAxisSpacing: 10.w,
                                childAspectRatio: 9.5 / 16,
                                children: List.generate(
                                    cubit.PostsFireBase.length,
                                    (index) => Material(
                                          borderRadius:
                                              BorderRadius.circular(15.r),
                                          color: Color.fromARGB(
                                              255, 234, 239, 241),
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          child: InkWell(
                                            onTap: () {
                                              cubit.changeCurrentTask(index);
                                              Navigation.goPush(
                                                context,
                                                Details_screen(
                                                  id: cubit
                                                      .PostsFireBase[index].id!,
                                                  cartModel: cubit
                                                      .PostsFireBase[index],
                                                ),
                                              );
                                            },
                                            child: Home_Builder(
                                              posts: cubit.PostsFireBase[index],
                                              //id: cubit.PostsFireBase[index].id!,
                                            ),
                                          ),
                                        )),
                              )
                            ],
                          ), 
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
