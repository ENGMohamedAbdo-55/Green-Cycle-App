import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_cycle_app/Features/auth/login/screen/login_screen.dart';
import 'package:green_cycle_app/Features/auth/register/contents.dart';
import 'package:green_cycle_app/core/components/colors.dart';
import 'package:green_cycle_app/core/components/navigation_const.dart';
import 'package:green_cycle_app/core/components/text_styles.dart';
import '../../../core/components/buttons.dart';
import '../../../core/components/textfield.dart';
import 'cubit/register_cubit.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم انشاء حسابك بنجاح'),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.green, // Adjust duration as needed
            ),
            // navigateAndFinish(context, HomeScreen());
          );
        } else if (state is RegisterErrorState) {
          const SnackBar(
            content: Text('هناك خطأ في انشاء الحساب'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red, // Adjust duration as needed
          );
        }
      },
      builder: (context, state) {
        var cubit = RegisterCubit.get(context);
        return Scaffold(
          appBar: CustomAppBar(
            onBackButtonPressed: () {
              navigateTo(context, const LoginScreen());
            },
            title: 'انشاء حساب',
          ),
          body: SingleChildScrollView(
            child: Form(
              key: cubit.formKey,
              child: Column(
                children: [
                  Image(
                    image: const AssetImage('assets/images/logo/logo.png'),
                    height: 100.h,
                    width: 100.w,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                    child: DefaultTextField(
                      suffixIcon: const Icon(Icons.person),
                      keyboardType: TextInputType.text,
                      controller: cubit.nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "الاسم لا يمكن ان يكون فارغ";
                        }
                        return null;
                      },
                      hintText: 'ادخل اسمك',
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                    child: DefaultTextField(
                      suffixIcon: const Icon(Icons.email),
                      keyboardType: TextInputType.emailAddress,
                      controller: cubit.emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "الحساب الالكتروني لا يمكن ان يكون فارغ";
                        }
                        return null;
                      },
                      hintText: 'البريد الالكتروني',
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                    child: DefaultTextField(
                      suffixIcon: const Icon(Icons.lock),
                      obsecure: cubit.isSecured,
                      keyboardType: TextInputType.text,
                      controller: cubit.passController,
                      prefixIcon: cubit.togglePass(),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'كلمه السر لا يمكن ان تكون فارغه';
                        } else if (value.length < 5) {
                          return 'كلمه السر لا يمكن ان تقل عن 5 حروف او ارقام';
                        }
                        return null;
                      },
                      hintText: 'الرقم السري',
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                    child: DefaultTextField(
                      suffixIcon: const Icon(Icons.phone),
                      keyboardType: TextInputType.text,
                      controller: cubit.phoneController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "الرقم لا يجب ان يكون فارغ";
                        }
                        return null;
                      },
                      hintText: 'رقم الهاتف',
                      onChanged: (value) {},
                      onFieldSubmitted: (value) {
                        if (cubit.formKey.currentState!.validate()) {
                          cubit.userRegister(
                            email: cubit.emailController.text,
                            password: cubit.passController.text,
                            name: cubit.nameController.text,
                            phone: cubit.phoneController.text,
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 20.h),
                  if (state is RegisterLoadingState)
                    CircularProgressIndicator(color: MyColors.greenColor)
                  else
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                      child: FirstBtn(
                        text1: 'انشاء حساب',
                        onPressed: () {
                          if (cubit.formKey.currentState!.validate()) {
                            cubit.userRegister(
                              email: cubit.emailController.text,
                              password: cubit.passController.text,
                              name: cubit.nameController.text,
                              phone: cubit.phoneController.text,
                            );
                          }
                        },
                      ),
                    ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          navigateTo(context, const LoginScreen());
                        },
                        child: Text('تسجيل الدخول',
                            style: TextStyle(
                                fontSize: 10.sp,
                                fontFamily: 'Cairo',
                                color: MyColors.greenColor,
                                decoration: TextDecoration.underline,
                                decorationColor: MyColors.greenColor)),
                      ),
                      Text(
                        'لديك بالفعل حساب؟',
                        style: AppStyles.greytextStyle9,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
