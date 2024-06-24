import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../login/screen/login_screen.dart';
import 'contents.dart';
import '../../../core/colors.dart';
import '../../../core/text_styles.dart';
import '../../../core/textfield.dart';
import '../../home/view/components/buttons.dart';
import '../../home/view/components/navigation_const.dart';
import 'cubit/register_cubit.dart';
import 'email_verify_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = RegisterCubit.get(context);
    return Scaffold(
      appBar: CustomAppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: MyColors.whiteColor,
        ),
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
              BlocBuilder<RegisterCubit, RegisterStates>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                    child: DefaultTextField(
                      suffixIcon: const Icon(Icons.lock),
                      obsecure: cubit.isSecured,
                      keyboardType: TextInputType.text,
                      controller: cubit.passController,
                      prefixIcon: cubit.togglePass(),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'كلمه المرور لا يجب ان تكون فارغه';
                        } else if (value.length < 6) {
                          return 'كلمه المرور لا يجب ان تكون اقل من 6';
                        }
                        return null;
                      },
                      hintText: 'كلمه المرور',
                    ),
                  );
                },
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
              BlocConsumer<RegisterCubit, RegisterStates>(
                listener: (context, state) {
                  if (state is RegisterSuccessState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('تم انشاء حسابك بنجاح'),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.green,
                      ),
                    );
                    navigateTo(context, const EmailVerificationScreen());
                  } else if (state is RegisterErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error), // Display error message
                        duration:const Duration(seconds: 3),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is RegisterLoadingState) {
                    return Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: CircularProgressIndicator(color: MyColors.greenColor),
                    );
                  }
                  return Padding(
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
                  );
                },
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
  }
}


//
