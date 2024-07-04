import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_cycle_app/Features/report/view/screens/reports_screen.dart';
import 'package:green_cycle_app/core/Services/Navigation.dart';
import 'package:green_cycle_app/core/Services/spacing.dart';

import '../../../../core/navigation_const.dart';
import '../../../../core/text_styles.dart';
import '../../../auth/login/cubit/login_cubit.dart';
import '../../../report/view/screens/create_report_screen.dart';
import 'post_Location.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginStates>(
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Drawer(child: Padding(
          padding:  EdgeInsets.only(left: 15.0.w,right: 15.w,top: 40.h),
          child: Center(
            child: ListView(children: [

              InkWell
                (
                // onTap:             () =>             Navigation.goPush(context,  CreateReportScreen())

                child: Row(
                  children: [
                    Icon(Icons.arrow_back_ios),Spacer(),
                    Text('عرض التقارير',style: AppStyles.textStyle16b,),

                  ],
                ),
              ),
              verticalSpace(15),
              Divider(),
              verticalSpace(15),
              InkWell(onTap: () =>                 LoginCubit.get(context).signOut(context)
                ,
                child: Row(
                  children: [
                    Icon(Icons.arrow_back_ios),Spacer(),
                    Text('تسجيل الخروج',style: AppStyles.textStyle16b,),

                  ],
                ),
              ),verticalSpace(15),
              Divider()

            ],),
          ),
        ),
            );
      },
    );
  }
}
