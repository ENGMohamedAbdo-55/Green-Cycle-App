
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_cycle_app/core/components/buttons.dart';
import 'package:green_cycle_app/core/components/colors.dart';
import 'package:green_cycle_app/core/components/textfield.dart';
import 'package:green_cycle_app/core/components/topBar.dart';

import '../cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoginCubit, LoginStates>(
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Form(
            key: cubit.formKey,
            child: Column(
              children: [
                const Stack(
                  children: [
                    TopBar(),
                  ],
                ),
                SizedBox(height: 20.h),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: Text(
                        'الاسم بالكامل',
                        style: TextStyle(
                          fontSize: 20.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: DefaultTextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: cubit.emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "الاسم لا يجب ان يكون فارغ";
                      }
                      return null;
                    },
                    hintText: 'ادخل اسمك',
                    suffixIcon: const Icon(Icons.person),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: DefaultTextField(
                    keyboardType: TextInputType.text,
                    obsecure: cubit.isSecured,
                    controller: cubit.passController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "كلمه المرور لا يجب ان تكون فارغه";
                      }
                      return null;
                    },
                    hintText: 'كلمة المرور',
                    suffixIcon: const Icon(Icons.lock),
                    prefixIcon: cubit.togglePass(),
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text('نسيت كلمه السر',
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: MyColors.greenColor,
                              decoration: TextDecoration.underline,
                              decorationColor: MyColors.greenColor)),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20,top: 20,left: 10,right: 10),
                  child: FirstBtn(text1: 'تسجيل الدخول', onPressed: (){}),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(onPressed: (){}, child:Text('انشاء حساب جديد',
                      style:TextStyle(
                      color: MyColors.greenColor,
                      ),

                    ),
                    ),
                    Text('ليس لديك حساب؟',),
                  ],
                ),

              ],
            ),
          );
        },
      ),
    );
  }
}
