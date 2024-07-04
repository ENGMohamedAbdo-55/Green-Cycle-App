import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_cycle_app/Features/cart/view%20model/manager/cubit/cart_cubit.dart';

import 'package:green_cycle_app/Features/home/Model/post_model.dart';
import 'package:green_cycle_app/Features/home/ViewModel/cubit/HomeScreenCubit.dart';
import 'package:green_cycle_app/Features/home/ViewModel/cubit/HomeScreenState.dart';
import 'package:green_cycle_app/Features/home/view/components/home/place_item.dart';
import 'package:green_cycle_app/core/Services/spacing.dart';

import '../../../../core/colors.dart';
import '../../../../core/navigation_const.dart';
import '../../../../core/text_styles.dart';
import '../../../../core/widgets.dart';
import 'package:green_cycle_app/Features/auth/model/user_model.dart';

import '../../../chat/ui/chat_screen.dart';
import '../../Model/post_model.dart';

class Details_screen extends StatelessWidget {
  String id;
  PostModelFireBase cartModel;
  User? user = FirebaseAuth.instance.currentUser;

  Details_screen({super.key, required this.id, required this.cartModel});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenCubit, HomeScreenState>(
      builder: (context, state) {
        var cubit = HomeScreenCubit.get(context);
        HomeScreenCubit.get(context).initControllerFireBase();

        return Scaffold(
          body: Padding(
            padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 30.h),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Image.network(
                        cubit.galleryUrl ??
                            cubit.cameraUrl ??
                            "assets/images/cart/cartlogo.png",
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
                    padding: EdgeInsets.all(15.0.r),
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
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                maxLines: 8,
                                cubit.titleController.text ?? '{id.title}',
                                style: AppStyles.textStyle20bbold,
                              ),
                            ),
                          ],
                        ),
                        verticalSpace(10),
                        // cubit.timeController.text.toString() ??
                        Text(
                          '25/4/2024',
                          textAlign: TextAlign.left,
                          style: AppStyles.textStyle14b,
                        ),
                        const Divider(
                          thickness: 0.7,
                          color: Colors.black,
                        ),
                        Row(children: [
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
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
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
                        Container(
                          width: 500.w,
                          height: 400.h,
                          // color: Colors.green,
                          child: MapScreen(),
                        ),
                        verticalSpace(10),
                        const Divider(
                          thickness: 0.7,
                          color: Colors.black,
                        ),
                        Text(
                          'طريقة الدفع',
                          textAlign: TextAlign.right,
                          style: AppStyles.textStyle18,
                        ),
                        verticalSpace(10),
                        Text(
                          textAlign: TextAlign.end,
                          maxLines: 5,
                          // cubit.locationController.text ??
                          "كاش",
                          style: AppStyles.textStyle14b,
                        ),
                        verticalSpace(10),
                        Divider(
                          thickness: 0.7,
                          color: Colors.black,
                        ),
                        verticalSpace(20),
                        InkWell(
                          onTap: () {
                            FirebaseFirestore.instance
                                .collection('Users')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .collection('Cart')
                                .add({
                              "cameraUrl": cartModel.cameraUrl ?? '',
                              "date": cartModel.date ?? '',
                              "description": cartModel.description ?? '',
                              "time": cartModel.time ?? '',
                              "title": cartModel.title ?? '',
                            }).then((value) {});
                          },
                          child: custombutton(
                              color: MyColors.greenColor,
                              fontcolor: Colors.white,
                              text: 'Add To Cart'),
                        ),
                        // SizedBox(
                        //   height: 20.h,
                        // ),
                        // IconButton(
                        //     onPressed: () {
                        //       ScaffoldMessenger.of(context).showSnackBar(
                        //         const SnackBar(
                        //           content: Text('تمت الاضافة بنجاح'),
                        //           duration: Duration(seconds: 2),
                        //           backgroundColor:
                        //               Colors.green, // Adjust duration as needed
                        //         ),
                        //       );
                        //       navigateTo(
                        //         context,
                        //         ChatScreen(
                        //           receiverModel: UserModel(
                        //             uId: cubit
                        //                 .PostsFireBase[cubit.currentTaskIndex]
                        //                 .uId,
                        //             image: cubit
                        //                 .PostsFireBase[cubit.currentTaskIndex]
                        //                 .image,
                        //             email: cubit
                        //                 .PostsFireBase[cubit.currentTaskIndex]
                        //                 .email,
                        //             name: cubit
                        //                 .PostsFireBase[cubit.currentTaskIndex]
                        //                 .name,
                        //             phone: cubit
                        //                 .PostsFireBase[cubit.currentTaskIndex]
                        //                 .phone,
                        //           ),
                        //         ),
                        //       );
                        //     },
                        //     icon: const Icon(Icons.chat)),
                        // InkWell(
                        //   onTap: () {
                        //     FirebaseFirestore.instance
                        //         .collection('Users')
                        //         .doc(FirebaseAuth.instance.currentUser!.uid)
                        //         .collection('Cart')
                        //         .add({
                        //       "cameraUrl": cartModel.cameraUrl ?? '',
                        //       "date": cartModel.date ?? '',
                        //       "description": cartModel.description ?? '',
                        //       "time": cartModel.time ?? '',
                        //       "title": cartModel.title ?? '',
                        //     }).then((value) {});
                        //   },
                        //   child: custombutton(
                        //       color: MyColors.greenColor,
                        //       fontcolor: Colors.white,
                        //       text: 'Add To Cart'),
                        // ),
                        SizedBox(
                          height: 20.h,
                        ),
                        InkWell(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('تمت الاضافة بنجاح'),
                                duration: Duration(seconds: 2),
                                backgroundColor:
                                    Colors.green, // Adjust duration as needed
                              ),
                            );
                            navigateTo(
                                context,
                                ChatScreen(
                                  receiverModel: UserModel(
                                    uId: cubit
                                        .PostsFireBase[cubit.currentTaskIndex]
                                        .uId,
                                    image: cubit
                                        .PostsFireBase[cubit.currentTaskIndex]
                                        .image,
                                    email: cubit
                                        .PostsFireBase[cubit.currentTaskIndex]
                                        .email,
                                    name: cubit
                                        .PostsFireBase[cubit.currentTaskIndex]
                                        .name,
                                    phone: cubit
                                        .PostsFireBase[cubit.currentTaskIndex]
                                        .phone,
                                  ),
                                ));
                          },
                          child: custombutton(
                              color: MyColors.greenColor,
                              fontcolor: Colors.white,
                              text: "Chat With Me"),
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
