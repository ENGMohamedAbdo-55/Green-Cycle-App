
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/components/colors.dart';
import '../../../core/components/text_styles.dart';
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback ?onBackButtonPressed;
  final String ?title;

  const CustomAppBar({
     this.onBackButtonPressed,
     this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new,color: MyColors.whiteColor,),
        onPressed: onBackButtonPressed,
      ),
      toolbarHeight: 110,
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
  Size get preferredSize => Size.fromHeight(110);
}

class AppBarClipper extends CustomClipper<Path>
{
  @override
  Path getClip(Size size)
  {
    double height=size.height;
    double width=size.width;
    var path =Path();
    path.lineTo(0,height-30);
    path.quadraticBezierTo(width/2,height,width, height - 30);
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