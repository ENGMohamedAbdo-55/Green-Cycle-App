import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'details_screen.dart';

import '../../../../core/Services/Navigation.dart';
import '../../../../core/colors.dart';
import '../../../auth/register/contents.dart';
import '../../ViewModel/cubit/HomeScreenCubit.dart';
import '../../ViewModel/cubit/HomeScreenState.dart';
import '../components/home/home_gridview_bilder.dart';

class All_Posts_Screen extends StatelessWidget {
  All_Posts_Screen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenCubit, HomeScreenState>(
        builder: (context, state) {
      var cubit = HomeScreenCubit.get(context);

      return Scaffold(
        appBar: CustomAppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
            color: MyColors.whiteColor,
          ),
          title: 'جميع الاعلانات',
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 20.0.w,
                  right: 20.w,
                ),
                child: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  mainAxisSpacing: 10.w,
                  crossAxisSpacing: 10.w,
                  childAspectRatio: 9.5 / 16,
                  children: List.generate(
                      cubit.PostsFireBase.length,
                      (index) => Material(
                            borderRadius: BorderRadius.circular(15.r),
                            color: Color.fromARGB(255, 234, 239, 241),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: InkWell(
                              onTap: () {
                                cubit.changeCurrentTask(index);
                                Navigation.goPush(
                                  context,
                                  Details_screen(
                                  
                                    id: cubit.PostsFireBase[index].id!,
                                    cartModel: cubit.PostsFireBase[index],
                                  ),
                                );
                              },
                              child: Home_Builder(
                                  posts: cubit.PostsFireBase[index]),
                            ),
                          )),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
