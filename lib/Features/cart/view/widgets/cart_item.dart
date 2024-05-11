import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/colors.dart';
import '../../../../core/text_styles.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 125,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: MyColors.backGroundGrey,
                          ),
                          child: ClipOval(
                            child:
                                Image.asset("assets/images/cart/cartlogo.png"),
                          ),
                        ),
                        Container(
                          width: 50,
                          height: 30,
                          decoration: BoxDecoration(
                            color: MyColors.backGroundGrey,
                            borderRadius: BorderRadius.circular(
                                10.0), // Adjust as desired
                          ),
                          child: const Center(
                            child: Text("حديد"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              " طن حديد مستعمل",
                              style: AppStyles.textStyle16b
                                  .copyWith(color: Colors.black),
                              textAlign: TextAlign.end,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "جنيه",
                                  style: AppStyles.textStyle11b,
                                ),
                                Text(
                                  "20000 ",
                                  style: AppStyles.textStyle14w
                                      .copyWith(color: MyColors.greenColor),
                                ),
                                Text(
                                  "السعر ",
                                  style: AppStyles.textStyle11b,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text("المنصورة , الدقهلية"),
                                Image.asset(
                                    "assets/images/cart/location_on 1.png"),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Image.asset("assets/images/cart/cartitemimg.png"),
                    ],
                  )
                ],
              ),
            ),
            Divider(
              color: MyColors.greyColor,
              height: 10.h,
              thickness: 1.5,
            ),
          ],
        ),
      ),
    );
  }
}
