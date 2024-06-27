part of 'chat_cubit.dart';

sealed class ChatStates {}

final class ChatInitial extends ChatStates {}

class GetAllUsersLoadingState extends ChatStates{}
class GetAllUsersSuccessState extends ChatStates{}
class GetAllUsersErrorState extends ChatStates{
  final String error;

  GetAllUsersErrorState(this.error);
}



class SendMessageSuccessState extends ChatStates{}
class SendMessageErrorState extends ChatStates{}
class GetMessageSuccessState extends ChatStates{}

class ChatUsersUpdatedState extends ChatStates {}
