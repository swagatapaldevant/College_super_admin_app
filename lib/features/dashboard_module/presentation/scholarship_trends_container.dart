import 'package:college_super_admin_app/core/network/apiHelper/locator.dart';
import 'package:college_super_admin_app/core/network/apiHelper/resource.dart';
import 'package:college_super_admin_app/core/network/apiHelper/status.dart';
import 'package:college_super_admin_app/core/services/localStorage/shared_pref.dart';
import 'package:college_super_admin_app/core/utils/commonWidgets/custom_shimmer.dart';
import 'package:college_super_admin_app/core/utils/constants/app_colors.dart';
import 'package:college_super_admin_app/core/utils/helper/common_utils.dart';
import 'package:college_super_admin_app/core/utils/helper/screen_utils.dart';
import 'package:college_super_admin_app/features/dashboard_module/data/dashboard_usecase.dart';
import 'package:college_super_admin_app/features/dashboard_module/widgets/recently_scholarship_students_container.dart';
import 'package:college_super_admin_app/features/dashboard_module/widgets/scholarship_trends_graph.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ScholarshipTrendsContainer extends StatefulWidget {
  const ScholarshipTrendsContainer({super.key});

  @override
  State<ScholarshipTrendsContainer> createState() =>
      _ScholarshipTrendsContainerState();
}

class _ScholarshipTrendsContainerState
    extends State<ScholarshipTrendsContainer> {
  bool isLoading = false;
  final DashboardUsecase _dashboardUsecase = getIt<DashboardUsecase>();
  final SharedPref _pref = getIt<SharedPref>();

  List<FlSpot> lineSpots = [];
  List<String> yearLabels = [];

  @override
  void initState() {
    super.initState();
    getDashboardData();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? loading()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScholarshipTrendsGraph(
                spots: lineSpots,
                yearLabels: yearLabels,
              ),
              SizedBox(height: ScreenUtils().screenHeight(context) * 0.015),
              Text(
                "Recently Scholarship Students",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.colorBlack,
                ),
              ),
              SizedBox(height: ScreenUtils().screenHeight(context) * 0.015),
              RecentlyScholarshipStudentsContainer(),
              SizedBox(height: ScreenUtils().screenHeight(context) * 0.03),
            ],
          );
  }

  Future<void> getDashboardData() async {
    setState(() => isLoading = true);

    Resource resource = await _dashboardUsecase.dashboardData(requestData: {});

    if (resource.status == STATUS.SUCCESS) {
      final response = resource.data as Map<String, dynamic>;
      final scholarshipGraph = response['scholarshipGraph'];

      if (scholarshipGraph != null) {
        List<int> years = List<int>.from(scholarshipGraph['labels']);
        List<double> revenueData = List<double>.from(
          (scholarshipGraph['series'][0] as List)
              .map((e) => (e as num).toDouble()),
        );

        List<FlSpot> spots = [];
        for (int i = 0; i < revenueData.length; i++) {
          spots.add(FlSpot(i.toDouble(), revenueData[i]));
        }

        setState(() {
          lineSpots = spots;
          yearLabels = years.map((e) => e.toString()).toList();
        });
      } else {
        CommonUtils().flutterSnackBar(
          context: context,
          mes: "No scholarship graph data available.",
          messageType: 4,
        );
      }
    } else {
      CommonUtils().flutterSnackBar(
        context: context,
        mes: resource.message ?? "Something went wrong",
        messageType: 4,
      );
    }

    setState(() => isLoading = false);
  }


  Widget loading(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //const Center(child: CircularProgressIndicator()),
        SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),
        CustomShimmer(
          height: ScreenUtils().screenHeight(context) * 0.02,
          width: ScreenUtils().screenWidth(context) * 0.45,
          radius:10,
        ),
        SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),
        CustomShimmer(
          height: ScreenUtils().screenHeight(context) * 0.27,
          width: ScreenUtils().screenWidth(context),
          radius:10,
        ),
        SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),
        CustomShimmer(
          height: ScreenUtils().screenHeight(context) * 0.02,
          width: ScreenUtils().screenWidth(context) * 0.45,
          radius:10,
        ),
        SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),
        CustomShimmer(
          height: ScreenUtils().screenHeight(context) * 0.05,
          width: ScreenUtils().screenWidth(context) ,
          radius:10,
        ),
        SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),
        CustomShimmer(
          height: ScreenUtils().screenHeight(context) * 0.05,
          width: ScreenUtils().screenWidth(context) ,
          radius:10,
        ),
        SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),
        CustomShimmer(
          height: ScreenUtils().screenHeight(context) * 0.05,
          width: ScreenUtils().screenWidth(context) ,
          radius:10,
        ),
        SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),
        CustomShimmer(
          height: ScreenUtils().screenHeight(context) * 0.05,
          width: ScreenUtils().screenWidth(context) ,
          radius:10,
        ),
        SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),
        CustomShimmer(
          height: ScreenUtils().screenHeight(context) * 0.05,
          width: ScreenUtils().screenWidth(context) ,
          radius:10,
        ),
      ],
    );
  }
}
