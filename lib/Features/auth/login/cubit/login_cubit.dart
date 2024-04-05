import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:green_cycle_app/core/components/colors.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../../../../firebase/models/users_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();


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
      color: MyColors.greyColor,
    );
  }

  // Fetch All Users OR User details
  Future<UserModel> getUserDetails(String email) async {
    final snapshot =
        await db.collection("Users").where("Email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }

  Future<List<UserModel>> allUser() async {
    final snapshot = await db.collection("Users").get();
    final userData =
        snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    return userData;
  }

  ///signIn with Google

  Future<void> signInWithGoogle() async {
    emit(GoogleSignInLoadingState());
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final UserCredential authResult =
            await auth.signInWithCredential(credential);
        final User? user = authResult.user;

        emit(GoogleSignInSuccessState(user));
      } else {
        emit(GoogleSignInErrorState("Google sign-in canceled"));
      }
    } catch (error) {
      emit(GoogleSignInErrorState("Google sign-in error: $error"));
    }
  }

  ///signIn with Email & Password
  void userLogin({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      emit(LoginSuccessState(userCredential.user!));
    } catch (error) {
      print(error.toString());
      String errorMessage;
      if (error.toString().contains('user-not-found')) {
        errorMessage = "This email is not registered";
      } else if (error.toString().contains('wrong-password')) {
        errorMessage = "Incorrect password";
      } else {
        errorMessage = "An error occurred: $error";
      }
      emit(LoginErrorState(errorMessage));
    }
  }


  ///signIn with Facebook

  Future<void> signInWithFacebook() async {
    try {
      emit(FaceBookSignInLoadingState());

      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Sign in to Firebase with the Facebook credentials
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
      emit(FaceBookSignInSuccessState(userCredential.user));
    } catch (error) {
      emit(FaceBookSignInErrorState(error.toString()));
    }
  }


  ///Reset Password

  void resetPassword({required String email}) async {
    emit(PasswordResetLoadingState());
    try {
      await auth.sendPasswordResetEmail(email: email);
      emit(PasswordResetEmailSentState());
    } catch (error) {
      emit(PasswordResetErrorState(error.toString()));
    }
  }

}
