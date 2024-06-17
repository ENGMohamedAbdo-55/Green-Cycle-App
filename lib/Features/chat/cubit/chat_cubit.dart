import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_cycle_app/Features/chat/model/message_model.dart';
import '../../auth/model/user_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(ChatInitial());

  static ChatCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;
  List<UserModel> users = [];

  ScrollController listScrollController = ScrollController();

  void getUsers() {
    emit(GetAllUsersLoadingState());
    FirebaseFirestore.instance.collection("Users").get().then((value) {
      value.docs.forEach((element) {
        users.add(UserModel.fromJson(element.data()));
      });
      emit(GetAllUsersSuccessState());
    }).catchError((error) {
      emit(GetAllUsersErrorState(error.toString()));
    });
  }

  void sendMessage({
    required String receiverID,
    required String dateTime,
    required String text,
  }) {



    MessageModel model = MessageModel(
      text: text,
      receiverID: receiverID,
      senderID: userModel!.uId,
      dateTime: dateTime,
    );
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverID)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      print('Message sent successfully to sender\'s chat');

      FirebaseFirestore.instance
          .collection('Users')
          .doc(receiverID)
          .collection('chats')
          .doc(userModel!.uId)
          .collection('messages')
          .add(model.toMap())
          .then((value) {
        print('Message sent successfully to receiver\'s chat');
        emit(SendMessageSuccessState());

        emit(GetMessageSuccessState());
        if (listScrollController.hasClients) {
          final position = listScrollController.position.maxScrollExtent;
          // listScrollController.jumpTo(position);
          listScrollController.animateTo(
            position,
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeOut,
          );
        }
      }).catchError((error) {
        print('Failed to send message to receiver\'s chat: $error');
        emit(SendMessageErrorState());
      });
    }).catchError((error) {
      print('Failed to send message to sender\'s chat: $error');
      emit(SendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({required String receiverID}) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverID)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      final int previousLength = messages.length;
      messages.clear();
      //messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(GetMessageSuccessState());

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (listScrollController.hasClients) {
          final position = listScrollController.position.maxScrollExtent +
              (messages.length - previousLength) * 15.0; // Height of separator
          listScrollController.animateTo(
            position,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    });
  }
}
