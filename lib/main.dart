import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_cycle_app/Features/onBoarding/onBoarding_Screen.dart';
import 'Features/auth/login/cubit/login_cubit.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
         providers: [
           BlocProvider(
            create: (BuildContext context)=>LoginCubit(),
        )
         ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: OnBoardingScreen(),
          ),
        );
      },
    );
  }
}
