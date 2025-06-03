import 'dart:ffi';

import 'package:college_super_admin_app/core/network/apiHelper/locator.dart';
import 'package:college_super_admin_app/core/network/apiHelper/resource.dart';
import 'package:college_super_admin_app/core/network/apiHelper/status.dart';
import 'package:college_super_admin_app/core/services/localStorage/shared_pref.dart';
import 'package:college_super_admin_app/core/utils/commonWidgets/custom_shimmer.dart';
import 'package:college_super_admin_app/core/utils/constants/app_colors.dart';
import 'package:college_super_admin_app/core/utils/helper/common_utils.dart';
import 'package:college_super_admin_app/core/utils/helper/screen_utils.dart';
import 'package:college_super_admin_app/features/dashboard_module/data/dashboard_usecase.dart';
import 'package:college_super_admin_app/features/dashboard_module/models/fees_collection_by_student_model.dart';
import 'package:college_super_admin_app/features/dashboard_module/models/home_payment_graph_model.dart';
import 'package:college_super_admin_app/features/dashboard_module/widgets/bar_chart.dart';
import 'package:college_super_admin_app/features/dashboard_module/widgets/dashboard_small_container.dart';
import 'package:college_super_admin_app/features/dashboard_module/widgets/dashboard_small_progress_section_container.dart';
import 'package:college_super_admin_app/features/dashboard_module/widgets/fees_received_current_balance_widget.dart';
import 'package:college_super_admin_app/features/dashboard_module/widgets/full_details_fees_collection_container.dart';
import 'package:college_super_admin_app/features/dashboard_module/widgets/new_admission_container.dart';
import 'package:college_super_admin_app/features/dashboard_module/widgets/total_fees_received_container.dart';
import 'package:flutter/material.dart';

class FeesReceivedContainer extends StatefulWidget {
  const FeesReceivedContainer({super.key});

  @override
  State<FeesReceivedContainer> createState() => _FeesReceivedContainerState();
}

class _FeesReceivedContainerState extends State<FeesReceivedContainer> {
  final DashboardUsecase _dashboardUsecase = getIt<DashboardUsecase>();
  final SharedPref _pref = getIt<SharedPref>();
  bool isLoading = false;
  List<HomePaymentGraphModel> paymentGraphList = [];
  List<String> dates = [];
  List<double> cash = [];
  List<double> others = [];
  List<FeesCollectionBystudentModel> studentList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDashboardData();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: isLoading?loadingWidget():Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FeesReceivedCurrentBalanceWidget(),
          SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),
          TotalFeesReceivedContainer(dates: dates, cash: cash, others: others,),
          SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),
          FullDetailsFeesCollectionContainer(studentList: studentList,),
          SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),


        ],
      ),
    );
  }

  getDashboardData() async {
    setState(() {
      isLoading = true;
    });

    Map<String, dynamic> requestData = {
      // "email": emailController.text.trim(),
      // "password": passwordController.text.trim()
    };

    Resource resource =
    await _dashboardUsecase.dashboardData(requestData: requestData);

    if (resource.status == STATUS.SUCCESS) {

      paymentGraphList = (resource.data["latestPayments"] as List)
          .map((x) => HomePaymentGraphModel.fromJson(x))
          .toList();

      for (var item in paymentGraphList) {
        dates.add(item.date ?? "");
        cash.add((item.cash?? 0).toDouble());
        others.add((item.others ?? 0).toDouble());
      }
      studentList= (resource.data["latest_student_paid"] as List)
          .map((x) => FeesCollectionBystudentModel.fromJson(x))
          .toList();


      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      CommonUtils().flutterSnackBar(
          context: context, mes: resource.message ?? "", messageType: 4);
    }
  }

  Widget loadingWidget(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomShimmer(
          height: ScreenUtils().screenHeight(context) * 0.1,
          width: ScreenUtils().screenWidth(context) ,
          radius: 10,
        ),
        SizedBox(height: ScreenUtils().screenHeight(context)*0.03,),
        CustomShimmer(
          height: ScreenUtils().screenHeight(context) * 0.02,
          width: ScreenUtils().screenWidth(context) * 0.4,
          radius: 10,
        ),
        SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomShimmer(
              height: ScreenUtils().screenHeight(context) * 0.05,
              width: ScreenUtils().screenWidth(context) * 0.3,
              radius: 10,
            ),
            CustomShimmer(
              height: ScreenUtils().screenHeight(context) * 0.05,
              width: ScreenUtils().screenWidth(context) * 0.3,
              radius: 10,
            ),
          ],
        ),
        SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),
        CustomShimmer(
          height: ScreenUtils().screenHeight(context) * 0.4,
          width: ScreenUtils().screenWidth(context) ,
          radius: 10,
        ),
        SizedBox(height: ScreenUtils().screenHeight(context)*0.03,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomShimmer(
              height: ScreenUtils().screenHeight(context) * 0.05,
              width: ScreenUtils().screenHeight(context) * 0.05 ,
              radius: ScreenUtils().screenHeight(context) * 0.05,
            ),
            CustomShimmer(
              height: ScreenUtils().screenHeight(context) * 0.05,
              width: ScreenUtils().screenWidth(context) * 0.4 ,
              radius: 10,
            ),
            CustomShimmer(
              height: ScreenUtils().screenHeight(context) * 0.05,
              width: ScreenUtils().screenWidth(context) * 0.15 ,
              radius: 10,
            ),
            CustomShimmer(
              height: ScreenUtils().screenHeight(context) * 0.05,
              width: ScreenUtils().screenWidth(context) * 0.15 ,
              radius: 10,
            ),

          ],
        )



      ],
    );
  }
}
