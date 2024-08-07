import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_cycle_app/Features/auth/model/user_model.dart';
import 'package:green_cycle_app/Features/chat/cubit/chat_cubit.dart';
import 'package:green_cycle_app/Features/chat/ui/chat_screen.dart';
import 'package:green_cycle_app/core/colors.dart';

import '../../../core/divider.dart';
import '../../../core/navigation_const.dart';
import '../../../core/text_styles.dart';
import '../../../core/topBar.dart';
import '../../home/view/components/buttons.dart';


class ChatHome extends StatelessWidget {
  const ChatHome({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = ChatCubit.get(context);
    return Scaffold(
      appBar: CustomAppBar2(
        title: 'الدردشه',
        leading: BackBtn(onPressed: () {
          Navigator.pop(context);
        }),
      ),
      body: BlocConsumer<ChatCubit, ChatStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (cubit.users.isEmpty) {
            return Center(
              child: Text(
                'لا يوجد رسائل بعد',
                style: AppStyles.textStyle18.copyWith(
                    color: MyColors.greyColor
                ),
              ),
            );
          }

          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: cubit.users.length,
            separatorBuilder: (BuildContext context, int index) =>
            const MyDivider2(),
            itemBuilder: (BuildContext context, int index) {
              return myChatItem(cubit.users[index], context);
            },
          );
        },
      ),
    );
  }

  Widget myChatItem(UserModel model, BuildContext context) {
    var cubit = ChatCubit.get(context);
    String lastMessage = cubit.getLastMessage(model.uId);
    return InkWell(
      onTap: () {
        navigateTo(
          context,
          ChatScreen(
            receiverModel: model,
          ),
        );
      },
      child: Container(
        alignment: Alignment.centerRight,
        height: 60.h,
        width: double.infinity,
        decoration: const BoxDecoration(color: Colors.transparent),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      model.name,
                      style: AppStyles.textStyle14.copyWith(fontWeight:FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      lastMessage,
                      style: AppStyles.textStyle14.copyWith(color: Colors.grey),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
              ),
              CircleAvatar(
                radius: 27.r,
                backgroundImage: NetworkImage(model.image??''),
              ),
            ],
          ),
        ),
      ),
    );

  }

}
