import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../ViewModel/cubit/HomeScreenCubit.dart';
import '../../ViewModel/cubit/HomeScreenState.dart';

import '../../../../core/colors.dart';

class Home_Screen extends StatelessWidget {
  const Home_Screen({Key?key}):super(key: key);

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
            body: cubit.layouts[cubit.currentindex]);
      },
    );
  }
}
