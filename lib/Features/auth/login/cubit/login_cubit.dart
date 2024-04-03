import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_cycle_app/core/components/colors.dart';

import '../../../../firebase/models/users_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context)=>BlocProvider.of(context);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController=TextEditingController();
  final TextEditingController passController=TextEditingController();



  final db= FirebaseFirestore.instance;

  //LoginModel? loginModel;

  bool isSecured = true;
  Widget togglePass() {
    return IconButton(
      onPressed: () {
        isSecured=!isSecured;
        emit(TogglePasswordState(isSecured));

      },
      icon: isSecured ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
      color: MyColors.greyColor,
    );
  }


  void createUser(UserModel user) async{
    await db.collection("Users").add(user.toJson()).then((_) {
      emit(LoginSuccessState("Account created successfully"));
    }).catchError((error) {
      emit(LoginErrorState("Error occurred: $error"));
    });
  }

  // Fetch All Users OR User details
  Future<UserModel> getUserDetails(String email) async {
    final snapshot = await db.collection("Users").where("Email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot (e)).single;
    return userData;
  }
  Future<List<UserModel>> allUser() async {
    final snapshot = await db.collection ("Users").get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot (e)).toList();
    return userData;
    }


}


