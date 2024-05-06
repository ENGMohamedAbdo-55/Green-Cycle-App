import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_cycle_app/Features/home/ViewModel/cubit/HomeScreenCubit.dart';
import 'package:green_cycle_app/Features/home/ViewModel/cubit/HomeScreenState.dart';
import 'package:green_cycle_app/core/Services/spacing.dart';

import '../../../../core/colors.dart';
import '../../../../core/widgets.dart';

class Details_screen extends StatelessWidget {
  const Details_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenCubit, HomeScreenState>(
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 30.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 300,
                      color: Colors.amberAccent,
                    ),
                    Padding(
                      padding: EdgeInsets.all(12.0.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.black,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.black,
                            child: IconButton(
                              onPressed: () {
                                // cubit.addToFav(id: id.id);
                              },
                              icon: const Icon(
                                Icons.favorite_border_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                verticalSpace(10),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Text('${id.title}',style: AppStyles.heading20,),
                      verticalSpace(10),
                      Row(children: [
                        //hometext2(text: "${id.category}"),
                        Spacer(),
                      ]),
                      verticalSpace(10),
                      Text(
                        'description',
                      ),
                      verticalSpace(10),
                      Container(
                        height: 190,
                        // child:

                        // Text( '${id.description}')
                      ),
                      verticalSpace(5),
                      InkWell(
                        //onTap: () => cubit.addtocart(id: id.id),
                        child: custombutton(
                            color: MyColors.greenColor,
                            fontcolor: Colors.white,
                            text: 'Add To Cart'),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
