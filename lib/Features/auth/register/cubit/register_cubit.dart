import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_cycle_app/Features/auth/model/user_model.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  bool isSecured = true;

  Widget togglePass() {
    return IconButton(
      onPressed: () {
        isSecured = !isSecured;
        emit(TogglePasswordState(isSecured));
      },
      icon: isSecured
          ? const Icon(Icons.visibility)
          : const Icon(Icons.visibility_off),
      color: Colors.grey,
    );
  }

  void userRegister({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoadingState());
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
            print("FirebaseAuth Value ${value.user!.uid}");
        userCreate(
          name: name,
          email: email,
          phone: phone,
          uId: value.user!.uid,
        );
        sendVerificationEmail(value.user!); // Send verification email
        emit(RegisterSuccessState());
      }).catchError((error) {
        emit(RegisterErrorState(error.toString()));
      });
    } catch (error) {
      emit(RegisterErrorState(error.toString()));
    }
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) async {
    emit(CreateUserLoadingState());
    UserModel model = UserModel(
      uId: uId,
      name: name,
      phone: phone,
      email: email,
      image:
          'https://i1.sndcdn.com/avatars-a7JCWthJzjAGAoxy-1jOiGg-t500x500.jpg',
    );

    try {
      // Check if the email is verified
      await FirebaseAuth.instance
          .authStateChanges()
          .firstWhere((user) => user != null && user.emailVerified);
      // Email is verified, proceed to store in Firestore
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(uId)
          .set(model.toMap())
          .then((value) {
        emit(CreateUserSuccessState());
      }).catchError((error) {
        emit(CreateUserErrorState(error.toString()));
      });
    } catch (error) {
      // Handle error
      if (kDebugMode) {
        print("Error verifying email: $error");
      }
      emit(CreateUserErrorState("Please verify your email before proceeding."));
    }
  }

  void sendVerificationEmail(User user) async {
    try {
      await user.sendEmailVerification();
      emit(VerificationEmailSentState());

      // email verification status
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user != null && user.emailVerified) {
          // email is verified
          emit(VerificationSuccessState());
        }
      });
    } catch (error) {
      if (kDebugMode) {
        print("Failed to send verification email: $error");
      }
      emit(VerificationEmailErrorState(error.toString()));
    }
  }
}