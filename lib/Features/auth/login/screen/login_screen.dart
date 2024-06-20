import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_cycle_app/Features/auth/login/reset_password.dart';
import 'package:green_cycle_app/Features/auth/login/screen/login_form.dart';
import 'package:green_cycle_app/Features/auth/register/contents.dart';
import 'package:green_cycle_app/Features/auth/register/register_screen.dart';
import 'package:green_cycle_app/Features/cart/view/screens/cartScreen.dart';
import 'package:green_cycle_app/Features/chat/ui/chat_home.dart';
import 'package:green_cycle_app/Features/profile/view/screens/profile_screen.dart';
import '../../../../core/Services/Navigation.dart';
import '../../../../core/colors.dart';
import '../../../../core/text_styles.dart';
import '../../../../core/textfield.dart';
import '../../../home/view/Screens/Home_Screen.dart';
import '../../../home/view/components/buttons.dart';
import '../../../home/view/components/navigation_const.dart';
import '../cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = LoginCubit.get(context);
    return BlocListener<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          Navigation.goPushReplace(context,  const Home_Screen());
        }
      },
      child: Scaffold(
        appBar: const CustomAppBar(
          title: 'مرحبا بك',
        ),
        body: Form(
          key: cubit.formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Image(
                  image: AssetImage('assets/images/logo/logo.png'),
                ),
                SizedBox(height: 25.h),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: DefaultTextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: cubit.emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "البريد الالكتروني لا يجب ان يكون فارغ";
                      }
                      return null;
                    },
                    hintText: 'البريد الالكتروني',
                    suffixIcon: const Icon(Icons.email),
                  ),
                ),
                BlocBuilder<LoginCubit, LoginStates>(
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: DefaultTextField(
                          keyboardType: TextInputType.text,
                          obsecure: cubit.isSecured,
                          controller: cubit.passController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'كلمه المرور لا يجب ان تكون فارغه';
                            } else if (value.length < 6) {
                              return 'كلمه المرور لا يجب ان تكون اقل من 6';
                            }
                            return null;
                          },
                          hintText: 'كلمة المرور',
                          suffixIcon: const Icon(Icons.lock),
                          prefixIcon: cubit.togglePass(),
                          onFieldSubmitted: (value) {
                            if (cubit.formKey.currentState!.validate()) {
                              cubit.userLogin(
                                email: cubit.emailController.text,
                                password: cubit.passController.text,
                                context: context,
                              );
                            }
                          }),
                    );
                  },
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        navigateTo(context, const ResetPassScreen());
                      },
                      child: Text('نسيت كلمه المرور',
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: MyColors.greenColor,
                              decoration: TextDecoration.underline,
                              decorationColor: MyColors.greenColor)),
                    )
                  ],
                ),
                BlocConsumer<LoginCubit, LoginStates>(
                  listener: (context, state) {
                    if (state is LoginSuccessState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('تم الدخول بنجاح'),
                          duration: Duration(seconds: 2),
                          backgroundColor:
                              Colors.green, // Adjust duration as needed
                        ),
                        // navigateAndFinish(context, HomeScreen());
                      );
                    } else if (state is LoginErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('حدث خطأ اثناء تسجيل الدخول حاول مره اخري'),
                          duration: Duration(seconds: 2),
                          backgroundColor:
                              Colors.red, // Adjust duration as needed
                        ),
                      );
                    }
                    if (state is LoginLoadingState) {
                      CircularProgressIndicator(color: MyColors.greenColor);
                    }
                  },
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          bottom: 20, top: 20, left: 10, right: 10),
                      child: FirstBtn(
                          text1: 'تسجيل الدخول',
                          onPressed: () async {
                            if (cubit.formKey.currentState!.validate()) {
                              cubit.userLogin(
                                context: context,
                                email: cubit.emailController.text,
                                password: cubit.passController.text,
                              );
                            }
                          }),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        navigateTo(context, const RegisterScreen());
                      },
                      child: Text(
                        'انشاء حساب جديد',
                        style: TextStyle(
                          color: MyColors.greenColor,
                        ),
                      ),
                    ),
                    Text(
                      'ليس لديك حساب؟',
                      style: AppStyles.textStyle11,
                    ),
                  ],
                ),
                const MyDivider(),
                SizedBox(height: 20.h),
                const GoogleAndFace(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
