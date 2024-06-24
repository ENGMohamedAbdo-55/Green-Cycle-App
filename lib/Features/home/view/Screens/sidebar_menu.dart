import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../ViewModel/cubit/HomeScreenCubit.dart';
import '../../ViewModel/cubit/HomeScreenState.dart';
import '../../../../core/Services/spacing.dart';
import '../../../../core/colors.dart';

import '../components/home/info_card.dart';

class Side_Bar_Screen extends StatelessWidget {
  const Side_Bar_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenCubit, HomeScreenState>(
      builder: (context, state) {
        return Scaffold(
          body: Container(
            width: 250.w,
            height: double.infinity,
            color: MyColors.greenColor,
            child: SafeArea(
              child: Column(
                children: [
                  verticalSpace(30),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      'mohamed',
                      style: TextStyle(fontSize: 17.sp, color: Colors.white),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    endIndent: 11.w,
                    indent: 11.w,
                  ),
                  verticalSpace(30),
                  Info_Card(icon: Icon(Icons.person), name: 'الملف الشخصي'),
                  Divider(
                    thickness: 1,
                    endIndent: 11.w,
                    indent: 11.w,
                  ),
                  Info_Card(icon: Icon(Icons.person), name: 'الملف الشخصي'),
                  Divider(
                    thickness: 1,
                    endIndent: 11.w,
                    indent: 11.w,
                  ),
                  Info_Card(icon: Icon(Icons.person), name: 'الملف الشخصي'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
