import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_app/Features/home/view/Screens/details_screen.dart';

class Navigation{
  static void goPush(context,Widget screen)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen,));
  }
  static void goPushReplace(context,Widget screen)
  {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => screen,));
  }

  static void pushReplacement(BuildContext context, Details_screen details_screen) {}
  
}