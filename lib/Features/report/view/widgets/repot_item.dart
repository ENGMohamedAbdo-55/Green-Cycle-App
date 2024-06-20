import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:green_cycle_app/Features/report/model/report_model.dart';
import 'package:green_cycle_app/Features/report/view%20model/cubit/report_cubit.dart';

import '../../../../core/colors.dart';
import '../../../../core/text_styles.dart';

class ReportItem extends StatelessWidget {
  ReportModel reports;
  ReportItem({
    super.key,
    required this.reports,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportCubit, ReportState>(
      builder: (context, state) {
        var cubit=ReportCubit.get(context);
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
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Icon(Icons.arrow_back_ios),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                 reports.description??"مخلفات للبيع",
                                  style: AppStyles.textStyle18
                                      .copyWith(color: Colors.black),
                                  textAlign: TextAlign.end,
                                ),
                                Row(
                                  children: [
                                     Text(reports.country??"not found"),
                                     const Text("-"),
                                     Text(reports.city??"not found"),
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
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                                12), // Adjust radius as needed
                            child:
                          
                             Image.asset(
                              "assets/images/cart/cartitemimg.png",
                              fit: BoxFit.cover, // Adjust fit as needed
                            ),
                          ),
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
      },
    );
  }
}
