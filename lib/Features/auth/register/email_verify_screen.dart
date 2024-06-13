import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/colors.dart';
import '../../../core/text_styles.dart';
import '../../home/view/Screens/Home_Screen.dart';
import '../../home/view/components/navigation_const.dart';
import 'contents.dart';
import 'cubit/register_cubit.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
            color: MyColors.whiteColor,
          ),
          title: 'تفعيل حسابك',
        ),
        body: BlocConsumer<RegisterCubit, RegisterStates>(
          listener: (context, state) {
            if(FirebaseAuth.instance.currentUser!.emailVerified)
            {
              navigateAndFinish(context,const Home_Screen());
            }
          },
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.email, size: 100, color: MyColors.greyColor),
                  Text(
                    'لقد قمنا بإرسال رسالة تأكيد إلى بريدك الإلكتروني.     \nيرجى تحقق من بريدك الإلكتروني واتباع التعليمات لتفعيل حسابك.',
                    style: AppStyles.textStyle11,
                  ),
                ],
              ),
            );
          },
        )
    );
  }
}
