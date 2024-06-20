import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_cycle_app/Features/auth/register/contents.dart';
import 'package:green_cycle_app/Features/cart/view/widgets/cart_item.dart';
import 'package:green_cycle_app/Features/cart/view/widgets/empty_cart_img.dart';
import 'package:green_cycle_app/Features/home/ViewModel/cubit/HomeScreenCubit.dart';
import 'package:green_cycle_app/Features/home/ViewModel/cubit/HomeScreenState.dart';

import '../../../../core/colors.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeScreenCubit, HomeScreenState>(
      listener: (context, state) {
        // TODO: implement listener
      },
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
            title: 'السله',
          ),
          body: (cubit.cartList ?? []).isEmpty
              ? const EmptyCartImg()
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: HomeScreenCubit.get(context).cartList.length ,
                          //HomeScreenCubit.get(context).cartList.length ,

                          itemBuilder: (context, Index) {
                            return  CartItem(
                              title: HomeScreenCubit.get(context).cartList[Index].title! ,
                              img:HomeScreenCubit.get(context).cartList[Index].galleryUrl! ,
                            );
                          }),
                    )
                  ],
                ),
        );
      },
    );
  }
}




// class CartScreen extends StatelessWidget {
//   const CartScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(Icons.arrow_back_ios),
//           color: MyColors.whiteColor,
//         ),
//         title: 'السله',
//       ),
//       body:  const SingleChildScrollView(
//         child: CartItem()
//       ),
//     );
//   }
// }
