import 'package:flutter/material.dart';
import 'package:green_cycle_app/Features/home/view/Screens/Home_Screen.dart';
import 'package:green_cycle_app/Features/home/view/layouts/post_screen.dart';
import 'package:green_cycle_app/core/Services/Navigation.dart';

class sas extends StatelessWidget {
  sas({super.key});
  // int currentStep = 0;
  // bool get isFirestStep => currentStep == 0;
  // bool get isLastStep => currentStep == steps().length - 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: InkWell(
          onTap: () {
            Navigation.goPush(context, Home_Screen());
          },
          child: Center(
            child: Text('data'),
          )),
    );
  }
}
