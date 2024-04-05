import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_cycle_app/Features/auth/login/reset_password.dart';
import 'package:green_cycle_app/Features/auth/login/screen/login_form.dart';
import 'package:green_cycle_app/Features/auth/register/contents.dart';
import 'package:green_cycle_app/Features/auth/register/register_screen.dart';
import 'package:green_cycle_app/core/components/buttons.dart';
import 'package:green_cycle_app/core/components/colors.dart';
import 'package:green_cycle_app/core/components/navigation_const.dart';
import 'package:green_cycle_app/core/components/text_styles.dart';
import 'package:green_cycle_app/core/components/textfield.dart';

import '../cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:const CustomAppBar(
        title: 'مرحبا بك',
      ),
      body: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state){
          if (state is LoginSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تم الدخول بنجاح'),
                duration: Duration(seconds: 2),
                backgroundColor: Colors.green, // Adjust duration as needed
              ),
              // navigateAndFinish(context, HomeScreen());
            );
          } else if (state is LoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                duration:const Duration(seconds: 2),
                backgroundColor: Colors.red, // Adjust duration as needed
              ),
            );
          }

          if (state is PasswordResetEmailSentState) {
            // Show a dialog or Snackbar to inform the user that a password reset email has been sent
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Password reset email sent. Check your email inbox.'),
                duration: Duration(seconds: 3),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is PasswordResetErrorState) {
            // Show a dialog or Snackbar to inform the user about the error in password reset process
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                duration: Duration(seconds: 3),
                backgroundColor: Colors.red,
              ),
            );
          }



        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Form(
            key: cubit.formKey,
            child: Column(
              children: [
                const Image(
                  image: AssetImage('assets/images/logo/logo.png'),
                ),
                SizedBox(height:25.h),
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
                     onFieldSubmitted: (value) {
                       if (cubit.formKey.currentState!.validate()) {
                         cubit.userLogin(
                           email: cubit.emailController.text,
                           password: cubit.passController.text,
                           context: context,
                         );
                       }
                     }
                     ),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        navigateTo(context,const ResetPassScreen());
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
                if (state is LoginLoadingState)
                  CircularProgressIndicator(color: MyColors.greenColor)
                else
                Padding(
                  padding: const EdgeInsets.only(bottom: 20,top: 20,left: 10,right: 10),
                  child: FirstBtn(text1: 'تسجيل الدخول', onPressed: ()async{

                    if (cubit.formKey.currentState!.validate()) {
                      cubit.userLogin(
                        context: context,
                        email: cubit.emailController.text,
                        password: cubit.passController.text,
                      );

                    }


                  }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(onPressed: (){
                      navigateTo(context,const RegisterScreen());
                    }, child:Text('انشاء حساب جديد',
                      style:TextStyle(
                      color: MyColors.greenColor,
                      ),

                    ),
                    ),
                    Text('ليس لديك حساب؟',
                    style: AppStyles.textStyle11,
                    ),
                  ],
                ),
                const MyDivider(),
                SizedBox(height: 20.h),
                const GoogleAndFace(),


              ],
            ),
          );
        },
      ),
    );
  }
}
