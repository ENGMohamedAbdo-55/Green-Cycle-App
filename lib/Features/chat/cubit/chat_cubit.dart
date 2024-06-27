import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_cycle_app/Features/chat/model/message_model.dart';
import 'package:green_cycle_app/core/Services/local/secure_keys.dart';
import '../../../core/Services/local/secure_storage.dart';
import '../../auth/model/user_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(ChatInitial());

  static ChatCubit get(context) => BlocProvider.of(context);
  List<UserModel> users = [];
  String? senderId;

  ScrollController listScrollController = ScrollController();

  init() async {
    SecureStorage secureStorage = SecureStorage();
    senderId = await secureStorage.getSecureData(SecureKeys.userId);
  }

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
    print('Sending message: SenderID = $senderId, ReceiverID = $receiverID');

    MessageModel model = MessageModel(
      text: text,
      receiverID: receiverID,
      senderID: senderId,
      dateTime: dateTime,
    );
    FirebaseFirestore.instance
        .collection('Users')
        .doc(senderId)
        .collection('chats')
        .doc(receiverID)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
      print('Message sent successfully to sender\'s chat');
      updateLastMessage(receiverID, text); // Update last message
    }).catchError((error) {
      print('Failed to send message to sender\'s chat: $error');
      emit(SendMessageErrorState());
      updateLastMessage(receiverID, text); // Update last message

      if (listScrollController.hasClients) {
        final position = listScrollController.position.maxScrollExtent;
        listScrollController.animateTo(
          position,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeOut,
        );
      }
    });
      if(senderId == receiverID){
        return;
      }
      else{
        FirebaseFirestore.instance
            .collection('Users')
            .doc(receiverID)
            .collection('chats')
            .doc(senderId)
            .collection('messages')
            .add(model.toMap())
            .then((value) {
          print('Message sent successfully to receiver\'s chat');
          emit(SendMessageSuccessState());
          print(value.toString());
          updateLastMessage(receiverID, text); // Update last message
        }).catchError((error) {
          print('Failed to send message to receiver\'s chat: $error');
          emit(SendMessageErrorState());
        });
      }

    emit(GetMessageSuccessState());
  }

  List<MessageModel> messages = [];

  void getMessages({required String receiverID}) {

    FirebaseFirestore.instance
        .collection('Users')
        .doc(senderId)
        .collection('chats')
        .doc(receiverID)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        print(element.data());
        messages.add(MessageModel.fromJson(element.data()));
      });
      messages.sort((a, b) => a.dateTime!.compareTo(b.dateTime!));
      if (messages.isNotEmpty) {
        updateLastMessage(receiverID, messages.last.text!); // Update last message
      }

      emit(GetMessageSuccessState());

      // Scroll to the end of the list after updating messages
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (listScrollController.hasClients) {
          final position = listScrollController.position.maxScrollExtent;
          listScrollController.animateTo(
            position,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    });
  }



  List<UserModel> chattedUsers = [];
  void addUser(UserModel user) {
    if (!users.any((existingUser) => existingUser.uId == user.uId)) {
      users.add(user);
      emit(ChatUsersUpdatedState());
    }
    if (!chattedUsers.any((existingUser) => existingUser.uId == user.uId)) {
      chattedUsers.add(user);

    }
  }

  bool hasChattedWith(UserModel user) {
    return chattedUsers.any((chattedUser) => chattedUser.uId == user.uId);
  }

  Map<String, String> lastMessages = {};

  String getLastMessage(String userId) {
    return lastMessages[userId] ?? '';
  }

  void updateLastMessage(String userId, String message) {
    lastMessages[userId] = message;
    emit(ChatUsersUpdatedState());
  }





}





