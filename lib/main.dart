import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_cycle_app/Features/auth/login/screen/login_screen.dart';
import 'package:green_cycle_app/Features/auth/register/cubit/register_cubit.dart';
import 'package:green_cycle_app/Features/onBoarding/onBoarding_Screen.dart';
import 'package:green_cycle_app/Features/splash/splash_screen.dart';
import 'Features/auth/login/cubit/login_cubit.dart';
import 'Features/home/view/layouts/user_account.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
  const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light
  )
  );
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

        ),
           BlocProvider(
             create: (BuildContext context)=>RegisterCubit(),
           ),

         ],
          child: const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
          ),
        );
      },
    );
  }
}
