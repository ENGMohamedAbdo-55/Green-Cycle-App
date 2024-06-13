part of 'register_cubit.dart';

@immutable
sealed class RegisterStates {}

final class RegisterInitial extends RegisterStates {}

class TogglePasswordState extends RegisterStates {
  final bool isSecured;
  TogglePasswordState(this.isSecured);

}

class RegisterLoadingState extends RegisterStates {}
class RegisterSuccessState extends RegisterStates {}
class RegisterErrorState extends RegisterStates {
  final String error;
  RegisterErrorState(this.error);
}


class CreateUserLoadingState extends RegisterStates {}
class CreateUserSuccessState extends RegisterStates {}
class CreateUserErrorState extends RegisterStates {
  final String error;
  CreateUserErrorState(this.error);
}

class VerificationEmailSentState extends RegisterStates {}
class VerificationSuccessState extends RegisterStates {}
class VerificationEmailErrorState extends RegisterStates {
  final String error;
  VerificationEmailErrorState(this.error);
}


/*
  final User user;
  RegisterSuccessState(this.user);
*/