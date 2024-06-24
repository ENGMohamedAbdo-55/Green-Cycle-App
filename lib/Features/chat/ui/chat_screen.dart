import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_cycle_app/Features/auth/model/user_model.dart';
import 'package:green_cycle_app/Features/chat/cubit/chat_cubit.dart';
import 'package:green_cycle_app/Features/chat/model/message_model.dart';

import '../../../core/colors.dart';
import '../../../core/text_styles.dart';
import '../../../core/textfield.dart';
import '../../home/view/components/buttons.dart';

class ChatScreen extends StatelessWidget {
  final UserModel userModel;

  const ChatScreen({Key? key, required this.userModel}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var cubit = ChatCubit.get(context);
    final TextEditingController messageController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.greenColor,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BackBtn(
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(width: 8.w),
            CircleAvatar(
              radius: 20.r,
              backgroundImage: NetworkImage('${userModel.image}'),
            ),
            SizedBox(width: 20.w), // Add some space between the widgets
            Text(
              '${userModel.name}',
              style: AppStyles.whiteTextStyle30,
            ),
          ],
        ),
      ),
      body: Builder(
        builder: (context) {
          cubit.userModel = userModel; // Set the userModel in ChatCubit
          cubit.getMessages(receiverID: userModel.uId ?? '');
          return BlocConsumer<ChatCubit, ChatStates>(
            listener: (context, state) {
              if (state is SendMessageSuccessState) {
                messageController.clear();
              } else if (state is SendMessageErrorState) {
                print('Error State');
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(height: 25.h),
                    Expanded(
                      child: ListView.separated(
                        controller: cubit.listScrollController,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var message = cubit.messages[index];
                          if (message.senderID == cubit.userModel!.uId) {
                            return buildMyMessage(context, message);
                          } else {
                            return buildMessage(context, message);
                          }
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 15.h),
                        itemCount: cubit.messages.length,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: ChatTextField(controller: messageController),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: FloatingActionButton(
                            shape: const CircleBorder(),
                            onPressed: () {
                              cubit.sendMessage(
                                receiverID: userModel.uId ?? '',
                                dateTime: DateTime.now().toString(),
                                text: messageController.text,
                              );
                            },
                            backgroundColor: MyColors.greenColor,
                            child: Icon(
                              Icons.send,
                              color: MyColors.whiteColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

Widget buildMessage(BuildContext context, MessageModel model) => Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width *
              0.7, // Adjust the maximum width as needed
        ),
        padding: EdgeInsets.symmetric(
          vertical: 5.h,
          horizontal: 10.w,
        ),
        decoration: BoxDecoration(
          color: MyColors.greyColor.withOpacity(.2),
          borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(20.r),
            topStart: Radius.circular(20.r),
            topEnd: Radius.circular(20.r),
          ),
        ),
        child: Text(
          '${model.text}',
          softWrap: true,
          style: AppStyles.chatTextStyle16,
          // Allow the text to wrap to the next line if it's too long
        ),
      ),
    );

Widget buildMyMessage(BuildContext context, MessageModel model) => Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width *
              0.7, // Adjust the maximum width as needed
        ),
        padding: EdgeInsets.symmetric(
          vertical: 5.h,
          horizontal: 10.w,
        ),
        decoration: BoxDecoration(
            color: MyColors.greenColor.withOpacity(0.2),
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(20.r),
              topStart: Radius.circular(20.r),
              topEnd: Radius.circular(20.r),
            )),
        child: Text(
          '${model.text}',
          style: AppStyles.chatTextStyle16,
          softWrap: true,
        ),
      ),
    );
