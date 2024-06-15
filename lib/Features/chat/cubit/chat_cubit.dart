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
    // print("userModel: $userModel");
    //
    // if (userModel == null) {
    //   emit(SendMessageErrorState());
    //   return;
    // }

    MessageModel model = MessageModel(
      text: text,
      receiverID: receiverID,
      senderID: '3DlnTn870Lcw46x2VzHlhzQ4dDE2',
      dateTime: dateTime,
    );
    FirebaseFirestore.instance
        .collection('Users')
        .doc('3DlnTn870Lcw46x2VzHlhzQ4dDE2')
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
          .doc('3DlnTn870Lcw46x2VzHlhzQ4dDE2')
          .collection('messages')
          .add(model.toMap())
          .then((value) {
        print('Message sent successfully to receiver\'s chat');
        emit(SendMessageSuccessState());
        // MessageModel messageModel = MessageModel(
        //   senderID: '3DlnTn870Lcw46x2VzHlhzQ4dDE2',
        //   receiverID: receiverID,
        //   dateTime: dateTime,
        //   text: text,
        // );
        // messages.add(messageModel);
        emit(GetMessageSuccessState());
        if (listScrollController.hasClients) {
          final position = listScrollController.position.maxScrollExtent;
          // listScrollController.jumpTo(position);
          listScrollController.animateTo(
            position,
            duration: Duration(milliseconds: 700),
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
        .doc('3DlnTn870Lcw46x2VzHlhzQ4dDE2')
        .collection('chats')
        .doc(receiverID)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(GetMessageSuccessState());
    });
  }
}
