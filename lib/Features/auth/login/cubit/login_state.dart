part of 'login_cubit.dart';

abstract class LoginStates {}
@immutable
class TogglePasswordState extends LoginStates {
  final bool isSecured;
  TogglePasswordState(this.isSecured);

}
class LoginInitial extends LoginStates {}
class LoginLoadingState extends LoginStates {}
class LoginSuccessState extends LoginStates {
  final User user;
  LoginSuccessState(this.user);

}
class LoginErrorState extends LoginStates {
}

///Google States

class GoogleSignInLoadingState extends LoginStates {}

class GoogleSignInSuccessState extends LoginStates {
  final User? user;
  GoogleSignInSuccessState(this.user);
}

class GoogleSignInErrorState extends LoginStates {
  final String error;
  GoogleSignInErrorState(this.error);
}

///FaceBook States

class FaceBookSignInLoadingState extends LoginStates {}
class FaceBookSignInSuccessState extends LoginStates {
  final User? user;
  FaceBookSignInSuccessState(this.user);
}
class FaceBookSignInErrorState extends LoginStates {
  final String error;
  FaceBookSignInErrorState(this.error);
}


///Reset Password States


class PasswordResetLoadingState extends LoginStates {}
class PasswordResetEmailSentState extends LoginStates {}
class PasswordResetErrorState extends LoginStates {
  final String error;
  PasswordResetErrorState(this.error);
}

