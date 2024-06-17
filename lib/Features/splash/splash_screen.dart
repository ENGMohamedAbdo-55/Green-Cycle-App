import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_app/Features/onBoarding/onBoarding_Screen.dart';

class SplashScreen extends StatelessWidget {
  final Widget startWidget;
  const SplashScreen({Key? key,required this.startWidget});

  @override
  Widget build(BuildContext context) {
    double iconSize = MediaQuery.of(context).size.width * 0.8;
    return AnimatedSplashScreen(
      splashTransition: SplashTransition.rotationTransition,
      splash: Center(
        child: Image.asset('assets/images/logo/splashLogo.png',
          width:iconSize ,
          height:iconSize ,
        ),
      ),
      splashIconSize: iconSize,
      nextScreen: startWidget
    );
  }
}
