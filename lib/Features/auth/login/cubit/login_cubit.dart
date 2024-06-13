import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../../../../core/colors.dart';
import '../../model/user_model.dart';
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
  UserModel? currentUser;

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

      User? user = userCredential.user;

      if (user != null && user.emailVerified) {
        emit(LoginSuccessState(user));
      } else if (user != null && !user.emailVerified) {
        // Email not verified
        auth.signOut(); // Sign out the user

        // Show Snackbar indicating that the email is not verified
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('البريد الإلكتروني لم يتم التحقق منه. الرجاء تحقق من بريدك الإلكتروني.'),
            duration: Duration(seconds: 5),
            backgroundColor: Colors.red,
          ),
        );

        emit(LoginErrorState());
      }
    } catch (error) {
      if (error.toString().contains('user-not-found')) {
      } else if (error.toString().contains('wrong-password')) {
      } else {
      }
      emit(LoginErrorState());
    }
  }


  ///signIn with Facebook

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider
        .credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
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
