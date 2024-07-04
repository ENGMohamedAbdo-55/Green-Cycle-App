import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:green_cycle_app/Features/report/model/report_model.dart';
import 'package:green_cycle_app/Features/report/view/screens/report_details_screen.dart';
import '../../../../core/Services/Navigation.dart';
import '../../view%20model/cubit/report_cubit.dart';

import '../../../../core/colors.dart';
import '../../../auth/register/contents.dart';
import '../widgets/repot_item.dart';

class ReportsScreen extends StatelessWidget {
  final ReportModel reportModel; // Receive reportModel as a parameter

  ReportsScreen({Key? key, required this.reportModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: ReportCubit.get(context)..getAllReportsFromFireBase(),
      child: BlocBuilder<ReportCubit, ReportState>(
        builder: (context, state) {
          var cubit = ReportCubit.get(context);
          return Scaffold(
            appBar: CustomAppBar(
              title: "التقارير",
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios),
                color: MyColors.whiteColor,
              ),
              actions: const [],
            ),
            body: (cubit.firebaseReports ?? []).isEmpty
                ? const Center(child: Text("no reports"))
                : ListView.builder(
              itemCount: cubit.firebaseReports.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigation.goPush(
                      context,
                      ReportDetailsScreen(id: cubit.firebaseReports[index].id!),
                    );
                  },
                  child: ReportItem(reports: cubit.firebaseReports[index]),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
