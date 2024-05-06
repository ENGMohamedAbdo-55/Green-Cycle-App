
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_cycle_app/Features/auth/register/contents.dart';

import '../../../../core/colors.dart';

class UserAccount extends StatelessWidget {
  const UserAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading:IconButton(onPressed: (){
          Navigator.pop(context);
        },
          icon:const Icon(Icons.arrow_back_ios),color: MyColors.whiteColor,),
        title: 'تعديل الملف',
      ),
      body: Center(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 70.r,
                  backgroundColor: MyColors.greyColor,
                ),
                IconButton(
                  onPressed: () {
                    // Add your onPressed functionality here
                  },
                  icon: Icon(Icons.add_a_photo),
                  color: Colors.black,
                  iconSize: 30.0.r,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
