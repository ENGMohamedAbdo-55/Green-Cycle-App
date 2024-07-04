import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_cycle_app/Features/home/view/Screens/search_screen.dart';
import '../../Screens/search_screen.dart';

import '../../../../../core/Services/Navigation.dart';
import '../../../../../core/Services/spacing.dart';
import '../../../../../core/colors.dart';
import '../../../../../core/text_styles.dart';
import '../../../../../core/widgets.dart';
import '../../Screens/sidebar_menu.dart';

class TopBar extends StatefulWidget {
  final double? buttonHeight;
  const TopBar({this.buttonHeight, super.key});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  List<QueryDocumentSnapshot> data = [];
  ironFilter() async {
    CollectionReference posts = FirebaseFirestore.instance.collection("posts");
    QuerySnapshot filter = await posts.where('title', isEqualTo: 'حديد').get();
    filter.docs.forEach((element) {
      data.add(element);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.buttonHeight ?? 165.h,
      decoration: BoxDecoration(
        color: MyColors.greenColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50.r),
          bottomRight: Radius.circular(50.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(right: 24.0.w, left: 24.w, top: 32.h),
        child: Column(
          children: [
            horizontalSpace(50),
            Row(
              children: [
                homeAppBar(
                  color: MyColors.blackColor,
                  icon: Icon(
                    Icons.dark_mode,
                    size: 25.sp,
                  ),
                ),
                const Spacer(),
                Text(
                  'كاربج',
                  style: AppStyles.textStyle32,
                ),
                const Spacer(),
                 IconButton(
                    color: Colors.white,
                    icon: const Icon(Icons.menu),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                  ),

              ],
            ),
            verticalSpace(16),
            Row(
              children: [
                homeAppBar(
                  color: Colors.black,
                  icon: const Icon(Icons.tune),
                ),
                horizontalSpace(16),
                InkWell(
                  onTap: () => Navigation.goPush(context, Search_Screen()),
                  child: Container(
                    width: 240.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: const Color.fromARGB(255, 224, 219, 219)),
                    child: Row(textDirection: TextDirection.rtl, children: [
                      horizontalSpace(20),
                      Icon(
                        Icons.search,
                        size: 35.sp,
                      ),
                      horizontalSpace(10),
                      Text(
                        'ما الذي تبحث عنه ؟',
                        textAlign: TextAlign.right,
                        style: AppStyles.textStyle14b,
                      ),
                    ]),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Post_Top_Bar extends StatelessWidget {
  const Post_Top_Bar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130.h,
      decoration: BoxDecoration(
        color: MyColors.greenColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50.r),
          bottomRight: Radius.circular(50.r),
        ),
      ),
      child: Padding(
          padding: EdgeInsets.only(right: 10.0.w, left: 30.w, top: 32.h),
          child: Center(
              child: ListTile(
            leading: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 30.sp,
            ),
            title: Text(
              'بيانات الإعلان ',
              style: AppStyles.textStyle32,
            ),
          ))),
    );
  }
}
