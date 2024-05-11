import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_cycle_app/Features/auth/register/cubit/register_cubit.dart';
import 'package:green_cycle_app/Features/home/ViewModel/cubit/HomeScreenCubit.dart';
import 'package:green_cycle_app/Features/home/view/Screens/Home_Screen.dart';
import 'package:green_cycle_app/Features/onBoarding/onBoarding_Screen.dart';
import 'package:green_cycle_app/Features/splash/splash_screen.dart';
import 'package:green_cycle_app/core/Services/local/secure_keys.dart';
import 'Features/auth/login/cubit/login_cubit.dart';
import 'Features/auth/login/screen/login_screen.dart';
import 'Features/home/view/Screens/details_screen.dart';
import 'Features/home/view/Screens/sidebar_menu.dart';
import 'core/Services/local/secure_storage.dart';
import 'core/observer.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light));
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = MyBlocObserver();
  Widget? widget;
  String? isLogin =
      await SecureStorage().storage.read(key: SecureKeys.userToken);

  if (isLogin != null) {
    widget = Home_Screen();
  } else {
    widget = OnBoardingScreen();
  }
  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp({Key? key, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    double iconSize = MediaQuery.of(context).size.width * 0.8;
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (BuildContext context) => LoginCubit(),
            ),
            BlocProvider(
              create: (BuildContext context) => RegisterCubit(),
            ),
            BlocProvider(
              create: (BuildContext context) =>
                  HomeScreenCubit()..getAllPostsFromFireBase(),
            )
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: AnimatedSplashScreen(
              splashTransition: SplashTransition.rotationTransition,
              splash: Center(
                child: Image.asset(
                  'assets/images/logo/splashLogo.png',
                  width: iconSize,
                  height: iconSize,
                ),
              ),
              splashIconSize: iconSize,
              nextScreen: startWidget,
            ),
          ),
        );
      },
    );
  }
}
