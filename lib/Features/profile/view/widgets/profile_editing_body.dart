import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/buttons.dart';
import '../../../../core/colors.dart';
import '../../../../core/text_styles.dart';
import '../../../../core/textfield.dart';
import '../../../auth/login/cubit/login_cubit.dart';
import '../../view model/cubit/profile_cubit.dart';

class ProfileEditingBody extends StatelessWidget {
  const ProfileEditingBody({
    super.key,
    required TextEditingController nameController,
    required TextEditingController phoneController,
    required TextEditingController emailController,
  }) : _nameController = nameController, _phoneController = phoneController, _emailController = emailController;

  final TextEditingController _nameController;
  final TextEditingController _phoneController;
  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.topCenter,
            child: CircleAvatar(
              radius: 80, // Adjust the radius as needed
              backgroundImage: AssetImage(
                  'assets/images/profile/th (9).jpeg'), // Change to your image path
            ),
          ),
    
          Text(
            _nameController.text,
            style: AppStyles.textStyle24,
          ),
    
          // const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "الاسم",
                    style: AppStyles.chatTextStyle16,
                    textAlign: TextAlign
                        .right, // Optional for stronger right alignment
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
            child: DefaultTextField(
              suffixIcon: const Icon(
                Icons.person,
                color: Colors.grey,
              ),
              prefixIcon: const Icon(Icons.edit),
              controller: _nameController,
              keyboardType: TextInputType.text,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "رقم الموبيل",
                    style: AppStyles.textStyle16,
                    textAlign: TextAlign
                        .right, // Optional for stronger right alignment
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
            child: DefaultTextField(
              suffixIcon: const Icon(
                Icons.phone,
                color: Colors.grey,
              ),
              prefixIcon: const Icon(Icons.edit),
              controller: _phoneController,
              keyboardType: TextInputType.text,
              //  افتكر ترجع لكنترولر في التكست فيلد
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "البريد الاكتروني ",
                    style: AppStyles.textStyle16,
                    textAlign: TextAlign
                        .right, // Optional for stronger right alignment
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
            child: DefaultTextField(
              readOnly: true,
              suffixIcon: const Icon(
                Icons.email,
                color: Colors.grey,
              ),
              controller: _emailController,
              keyboardType: TextInputType.text,
            ),
          ),
          const SizedBox(height: 15),
          Container(
              height: 73.h,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: FirstBtn(
                  text1: "تعديل الملف",
                  onPressed: () {
                    context
                        .read<UserProfileCubit>()
                        .updateUserProfile(
                          _nameController.text,
                          _phoneController.text,
                        );
                  })),
          Container(
            height: 50.h,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: MyColors.whiteColor,
              border: Border.all(
                color: MyColors.greenColor, // Green border color
                width: 2.0, // Width of the border
              ),
            ),
            child: TextButton(
              onPressed: () {
                LoginCubit.get(context).signOut(context);
              },
              child: Text(
                "تسجيل الخروج",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: MyColors.greenColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
