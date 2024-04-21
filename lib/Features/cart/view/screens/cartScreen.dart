import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_cycle_app/Features/auth/register/contents.dart';
import 'package:green_cycle_app/Features/cart/view/widgets/cart_item.dart';
import 'package:green_cycle_app/Features/cart/view/widgets/empty_cart_img.dart';
import 'package:green_cycle_app/core/components/colors.dart';
import 'package:green_cycle_app/core/components/text_styles.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body:  const SingleChildScrollView(
        child: EmptyCartImg()
      ),
    );
  }
}

