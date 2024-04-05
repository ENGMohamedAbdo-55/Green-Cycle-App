part of 'register_cubit.dart';

@immutable
sealed class RegisterStates {}

final class RegisterInitial extends RegisterStates {}

class TogglePasswordState extends RegisterStates {
  final bool isSecured;
  TogglePasswordState(this.isSecured);

}

class RegisterLoadingState extends RegisterStates {}
class RegisterSuccessState extends RegisterStates {
  final User user;
  RegisterSuccessState(this.user);
}
class RegisterErrorState extends RegisterStates {
  final String error;
  RegisterErrorState(this.error);
}
