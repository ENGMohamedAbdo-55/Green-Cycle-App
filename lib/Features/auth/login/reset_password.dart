import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'cubit/login_cubit.dart';
import '../register/contents.dart';

import '../../../core/colors.dart';
import '../../../core/textfield.dart';
import '../../home/view/components/buttons.dart';


class ResetPassScreen extends StatelessWidget {
  const ResetPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

    var cubit = LoginCubit.get(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'تعيين كلمة المرور',
        leading:IconButton(onPressed: () {
          Navigator.pop(context);
        },
          icon: const Icon(Icons.arrow_back_ios), color: MyColors.whiteColor,),

      ),
      body: Column(
        children: [
          Text(
            'ادخل بريدك الالكتروني لتصلك رسالة عليه لتغيير كلمة المرور',
            style: TextStyle(
              fontSize: 12.sp,
              fontFamily: 'Cairo',
            ),
          ),
          SizedBox(height: 35.h),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: DefaultTextField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
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
          BlocConsumer<LoginCubit, LoginStates>(
            listener: (context, state) {
              if (state is PasswordResetErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                    duration: const Duration(seconds: 2),
                    backgroundColor: Colors.red, // Adjust duration as needed
                  ),
                );
              }
            },
            builder: (context, state) {
              return state is PasswordResetLoadingState
                  ? CircularProgressIndicator(color: MyColors.greenColor)
                  : Padding(
                padding: const EdgeInsets.all(10.0),
                child: FirstBtn(
                  text1: 'تأكيد',
                  onPressed: () {
                    cubit.resetPassword(email: emailController.text);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
