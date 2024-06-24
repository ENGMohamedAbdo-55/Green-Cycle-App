import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/textfield.dart';
import '../../../../core/widgets.dart';
import '../../../../core/buttons.dart';
import '../../../../core/colors.dart';
import '../../../../core/text_styles.dart';
import '../../../auth/register/contents.dart';
import '../../view model/cubit/profile_cubit.dart';
import '../../view model/cubit/profile_state.dart';
import '../widgets/profile_editing_body.dart';

class UserProfileScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => UserProfileCubit()..loadUserProfile()),
      ],
      child: Scaffold(
        appBar: CustomAppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
            color: MyColors.whiteColor,
          ),
          title: ' تعديل الملف',
        ),
        body: BlocBuilder<UserProfileCubit, UserProfileState>(
          builder: (context, state) {
            if (state is UserProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserProfileLoaded) {
              _nameController.text = state.name;
              _phoneController.text = state.phone;
              _emailController.text = state.email;
              return SingleChildScrollView(
                child: ProfileEditingBody(
                    nameController: _nameController,
                    phoneController: _phoneController,
                    emailController: _emailController),
              );
            } else if (state is UserProfileError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('No User Data'));
            }
          },
        ),
      ),
    );
  }
}
