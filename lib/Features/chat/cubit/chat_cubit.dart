import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_cycle_app/Features/chat/model/message_model.dart';
import '../../auth/model/user_model.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(ChatInitial());
  static ChatCubit get(context) => BlocProvider.of(context);
   UserModel? userModel;
  List<UserModel> users=[];


  void getUsers() {
    emit(GetAllUsersLoadingState());
    FirebaseFirestore.instance.collection("Users").get().then((value) {
     value.docs.forEach((element)
         {

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
    if (userModel == null) {
      emit(SendMessageErrorState());
      return;
    }

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
      }).catchError((error) {
        print('Failed to send message to receiver\'s chat: $error');
        emit(SendMessageErrorState());
      });
    }).catchError((error) {
      print('Failed to send message to sender\'s chat: $error');
      emit(SendMessageErrorState());
    });
  }


  List<MessageModel> messages=[];

  void getMessages({
    required String receiverID
  }) {
    if (userModel != null) {
      FirebaseFirestore.instance
          .collection('Users')
          .doc(userModel!.uId)
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


}
