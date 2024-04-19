import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_cycle_app/Features/home/ViewModel/HomeScreenCubit.dart';
import 'package:green_cycle_app/Features/home/ViewModel/HomeScreenState.dart';
import 'package:green_cycle_app/core/components/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeScreenCubit, HomeScreenState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = HomeScreenCubit.get(context);
        return Scaffold(
          extendBody: true,
          bottomNavigationBar: CurvedNavigationBar(
              backgroundColor: Colors.transparent,
              color: MyColors.greenColor,
              items: cubit.items,
              index: cubit.currentindex,
              height: 50.h,
              onTap: (currentindex) => cubit.changecurrentindex(currentindex),
            ),
            body: cubit.layouts[cubit.currentindex]
        );
      },
    );
  }
}
