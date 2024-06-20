import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:green_cycle_app/Features/cart/view%20model/manager/cubit/cart_cubit.dart';

import 'package:green_cycle_app/Features/home/Model/post_model.dart';
import 'package:green_cycle_app/Features/home/ViewModel/cubit/HomeScreenCubit.dart';
import 'package:green_cycle_app/Features/home/ViewModel/cubit/HomeScreenState.dart';
import 'package:green_cycle_app/core/Services/spacing.dart';

import '../../../../core/colors.dart';
import '../../../../core/text_styles.dart';
import '../../../../core/widgets.dart';

class Details_screen extends StatelessWidget {
  String id;
  PostModelFireBase cartModel;
  Details_screen({
    Key? key,
    required this.id,
    required this.cartModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenCubit, HomeScreenState>(
      builder: (context, state) {
        HomeScreenCubit.get(context).initControllerFireBase();
        var cubit = HomeScreenCubit.get(context);

        return Scaffold(
          body: Padding(
            padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 30.h),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Image.network(
                        cubit.cameraUrl ?? "assets/images/cart/cartitemimg.png",
                        width: double.infinity,
                        height: 300, fit: BoxFit.fill,

                        // color: Colors.amberAccent,
                      ),
                      Padding(
                        padding: EdgeInsets.all(12.0.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: 30.sp,
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
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 48.w,
                              child: Card(
                                child: Text(
                                  'جديد',
                                  textAlign: TextAlign.center,
                                  style: AppStyles.greenTextStyle10,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Expanded(
                              flex: 15,
                              child: Text(
                                textAlign: TextAlign.end,
                                maxLines: 8,
                                cubit.titleController.text ?? '{id.title}',
                                style: AppStyles.textStyle20bbold,
                              ),
                            ),
                          ],
                        ),
                        verticalSpace(10),
                        Text(
                          // cubit.timeController.text.toString() ??
                          '25/4/2024',
                          textAlign: TextAlign.left,
                          style: AppStyles.textStyle14b,
                        ),
                        const Divider(
                          thickness: 0.7,
                          color: Colors.black,
                        ),
                        const Row(children: [
                          //hometext2(text: "${id.category}"),
                          Spacer(),
                        ]),
                        verticalSpace(10),
                        Text(
                          'الوصف',
                          textAlign: TextAlign.right,
                          style: AppStyles.textStyle18,
                        ),
                        verticalSpace(10),
                        Text(
                          textAlign: TextAlign.end,
                          maxLines: 2,
                          cubit.descriptionController.text ?? '......',
                          style: AppStyles.textStyle14b,
                        ),
                        verticalSpace(10),
                        const Divider(
                          thickness: 0.7,
                          color: Colors.black,
                        ),
                        Text(
                          'الموقع',
                          textAlign: TextAlign.right,
                          style: AppStyles.textStyle18,
                        ),
                        verticalSpace(10),
                        Text(
                          textAlign: TextAlign.end,
                          maxLines: 5,
                          // cubit.locationController.text ??
                          "المنصورة/الدقهلية",
                          style: AppStyles.textStyle14b,
                        ),
                        verticalSpace(10),
                        const Divider(
                          thickness: 0.7,
                          color: Colors.black,
                        ),
                        verticalSpace(25),
                        InkWell(
                          onTap: () {
                            FirebaseFirestore.instance
                                .collection('Users')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .collection('Cart')
                                .add({
                              "cameraUrl": cartModel.cameraUrl,
                              "date": cartModel.date,
                              "description": cartModel.description,
                              "galleryUrl": cartModel.galleryUrl,
                              "time": cartModel.time,
                              "title": cartModel.title,
                            
                            }
                            
                            ).then((value) {
                              Fluttertoast.showToast(
                                  msg: "this post is added to favorite",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            });
                          },
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
          ),
        );
      },
    );
  }
}
