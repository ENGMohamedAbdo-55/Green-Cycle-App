import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_cycle_app/core/components/colors.dart';

class Generalbtn extends StatelessWidget {
    const Generalbtn({required this.text,super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(onPressed: (){
          },
            style:ElevatedButton.styleFrom(
              shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
              ),
            ), child: Text(text,
          style: TextStyle(
            color: greenColor,
            fontSize: 20
          ),
          ),


          ),
        ),
      ),
    );
  }
}
class FirstBtn extends StatelessWidget {
   const FirstBtn({required this.text1,super.key,required this.onPressed});
   final String text1;
   final VoidCallback? onPressed;

   @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color:greenColor
      ),
      child: TextButton(onPressed: onPressed,child: Text(text1,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
        color:whiteColor
      ),
      ),
      ),
    );
  }
}

