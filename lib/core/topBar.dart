import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Services/spacing.dart';
import 'colors.dart';
import 'text_styles.dart';
import 'widgets.dart';

class TopBar extends StatelessWidget {
  final double? buttonHeight;
  const TopBar({this.buttonHeight, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: buttonHeight ?? 177.h,
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
                    color: Colors.black, icon: Icon(Icons.notifications)),
                Spacer(),
                Text(
                  'كاربج',
                  style: AppStyles.homeHeader,
                ),
                Spacer(),
                homeAppBar(
                    color: MyColors.blackColor, icon: Icon(Icons.filter_3))
              ],
            ),
            verticalSpace(16),
            Row(
              children: [
                homeAppBar(color: Colors.black, icon: Icon(Icons.tune)),
                horizontalSpace(16),
                Container(
                  width: 250.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 224, 219, 219)),
                  child: ListTile(
                    trailing: Icon(
                      Icons.search,
                      size: 35.sp,
                    ),
                    title: Text(
                      'ما الذي تبحث عنه ؟',
                      textAlign: TextAlign.right,
                      style: AppStyles.textStyle14,
                    ),
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


class CustomAppBar2 extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback ?onBackButtonPressed;
  final String ?title;
  final Widget ?leading; // Reusable leading widget


  const CustomAppBar2({
    this.leading,
    this.onBackButtonPressed,
    this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      toolbarHeight: 110.h,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      flexibleSpace: ClipPath(
        clipper: AppBarClipper(),
        child: Container(
          height: 200.h,
          width: MediaQuery.of(context).size.width,
          color: MyColors.greenColor,
          child: Center(
            child: Text(
              title?? '',
              style: AppStyles.heading20,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70);
}

class AppBarClipper extends CustomClipper<Path>
{
  @override
  Path getClip(Size size)
  {
    double height=size.height;
    double width=size.width;
    var path =Path();
    path.lineTo(0,height-20);
    path.quadraticBezierTo(width/2,height,width, height - 20);
    path.lineTo(width,0);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper)
  {
    return true;
  }
}

