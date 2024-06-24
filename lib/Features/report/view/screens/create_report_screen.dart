import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_cycle_app/Features/auth/register/contents.dart';
import 'package:green_cycle_app/Features/report/view%20model/cubit/report_cubit.dart';

import '../../../../core/colors.dart';
import '../../../../core/text_styles.dart';
import '../../../../core/textfield.dart';
import '../../../home/view/components/buttons.dart';
import '../widgets/img_picker.dart';

class CreateReportScreen extends StatelessWidget {
  const CreateReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportCubit, ReportState>(
      builder: (context, state) {
        ReportCubit.get(context).clearReportController();
        var cubit = ReportCubit.get(context);
        return Scaffold(
            appBar: CustomAppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios),
                color: MyColors.whiteColor,
              ),
              title: 'انشاء تقرير',
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: cubit.addReportKey,
                  child: Column(
                    children: [
                      ImagePicker(),
        //              Container(
        // width: double.infinity,
        // height: 180,
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(16.0),
        //   color: MyColors.backGroundGrey,
          
        //                 ), child:Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Image.asset(
        //               "assets/images/report/photo_camera 1.png"),
        //           Text(
        //             "فتح كاميرا",
        //             style: AppStyles.textStyle30,
        //           ),
        //         ],
        //       ),  ), // Adjust
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "البلد",
                                style: AppStyles.textStyle18,
                                textAlign: TextAlign
                                    .right, // Optional for stronger right alignment
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 54,
                        child: DefaultTextField(
                          controller: cubit.countryController,
                          keyboardType: TextInputType.text,
                      
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "البلد لا يجب ان تكون فارغ";
                            }
                            return null;
                          },
                          hintText: "ادخل البلد",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "المدينه",
                                style: AppStyles.textStyle18,
                                textAlign: TextAlign
                                    .right, // Optional for stronger right alignment
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 54,
                        child: DefaultTextField(
                          controller: cubit.cityController,
                          keyboardType: TextInputType.text,
                          //  افتكر ترجع لكنترولر في التكست فيلد
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "لابد من اختيار المدينه";
                            }
                            return null;
                          },
                          hintText: " اختيار المدينه",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "العنوان",
                                style: AppStyles.textStyle18,
                                textAlign: TextAlign
                                    .right, // Optional for stronger right alignment
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 54,
                        child: DefaultTextField(
                          controller: cubit.addressController,
                          keyboardType: TextInputType.text,
                          //  افتكر ترجع لكنترولر في التكست فيلد
                          validator: (value) {
                            if (value!.isEmpty) {
                              return " لا يجب ان يكون العنوان فارغ";
                            }
                            return null;
                          },
                          hintText: "ادخل العنوان",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "الوصف",
                                style: AppStyles.textStyle18,
                                textAlign: TextAlign
                                    .right, // Optional for stronger right alignment
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 54,
                        child: DefaultTextField(
                          controller: cubit.descriptionController,
                          keyboardType: TextInputType.text,
                          //  افتكر ترجع لكنترولر في التكست فيلد
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "يجب ادخال الوصف";
                            }
                            return null;
                          },
                          hintText: "ادخل الوصف",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: FirstBtn(
                            text1: "ارسال",
                            onPressed: () {
                              if (cubit.addReportKey.currentState!.validate())
                              {
                                cubit.addReportToFireBase();
                              }
                            }),
                      )
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}

