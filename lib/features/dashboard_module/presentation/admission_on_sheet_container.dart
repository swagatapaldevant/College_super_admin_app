import 'package:college_super_admin_app/core/network/apiHelper/locator.dart';
import 'package:college_super_admin_app/core/network/apiHelper/resource.dart';
import 'package:college_super_admin_app/core/network/apiHelper/status.dart';
import 'package:college_super_admin_app/core/services/localStorage/shared_pref.dart';
import 'package:college_super_admin_app/core/utils/commonWidgets/custom_shimmer.dart';
import 'package:college_super_admin_app/core/utils/constants/app_colors.dart';
import 'package:college_super_admin_app/core/utils/helper/common_utils.dart';
import 'package:college_super_admin_app/core/utils/helper/screen_utils.dart';
import 'package:college_super_admin_app/features/dashboard_module/data/dashboard_usecase.dart';
import 'package:college_super_admin_app/features/dashboard_module/models/admission_by_month_name.dart';
import 'package:college_super_admin_app/features/dashboard_module/widgets/admission_result_every_month_container.dart';
import 'package:flutter/material.dart';

class AdmissionOnSheetContainer extends StatefulWidget {
  const AdmissionOnSheetContainer({super.key});

  @override
  State<AdmissionOnSheetContainer> createState() =>
      _AdmissionOnSheetContainerState();
}

class _AdmissionOnSheetContainerState extends State<AdmissionOnSheetContainer> {
  final DashboardUsecase _dashboardUsecase = getIt<DashboardUsecase>();
  final SharedPref _pref = getIt<SharedPref>();
  bool isLoading = false;
  List<AdmissionByMonthName> admissionDataByMonth = [];
  List<AdmissionByYear> admissionDataByYear = [];
  List<String> month = [];
  List<int> count = [];

  List<String> year = [];
  List<int> stnCount = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDashboardData();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
            child:isLoading
                ? loadingWidget()
                :  Column(
              children: [
                AdmissionResultEveryMonthContainer(
                  weekDays: month,
                  blueData: count,
                  text: 'Admission result every month',
                ),
                SizedBox(
                  height: ScreenUtils().screenHeight(context) * 0.015,
                ),
                AdmissionResultEveryMonthContainer(
                  weekDays: year,
                  blueData: stnCount,
                  text: "Admission result every Year",
                ),
                SizedBox(
                  height: ScreenUtils().screenHeight(context) * 0.02,
                ),
                // Text(
                //   'Download full result in pdf ',
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //       fontSize: 12,
                //       fontFamily: "Poppins",
                //       fontWeight: FontWeight.w500,
                //       color: AppColors.gray7),
                // ),
                // Text(
                //   'Download ',
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //       fontSize: 12,
                //       fontWeight: FontWeight.bold,
                //       fontFamily: "Poppins",
                //       color: AppColors.blue),
                // ),
                SizedBox(
                  height: ScreenUtils().screenHeight(context) * 0.02,
                ),
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
      admissionDataByMonth = (resource.data["admissionsByMonthName"] as List)
          .map((x) => AdmissionByMonthName.fromJson(x))
          .toList();

      for (var item in admissionDataByMonth) {
        month.add(item.month ?? "");
        count.add(item.count ?? 0);
      }

      admissionDataByYear = (resource.data["admissionsYearly"] as List)
          .map((x) => AdmissionByYear.fromJson(x))
          .toList();

      for (var item in admissionDataByYear) {
        year.add(item.year.toString() ?? "");
        stnCount.add(item.count ?? 0);
      }
      print(year);

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
        SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),

        CustomShimmer(
          height: ScreenUtils().screenHeight(context) * 0.02,
          width: ScreenUtils().screenWidth(context)*0.5 ,
          radius: 10,
        ),
        SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),
        CustomShimmer(
          height: ScreenUtils().screenHeight(context) * 0.3,
          width: ScreenUtils().screenWidth(context) ,
          radius: 10,
        ),
        SizedBox(height: ScreenUtils().screenHeight(context)*0.03,),

        CustomShimmer(
          height: ScreenUtils().screenHeight(context) * 0.02,
          width: ScreenUtils().screenWidth(context)*0.5 ,
          radius: 10,
        ),
        SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),
        CustomShimmer(
          height: ScreenUtils().screenHeight(context) * 0.3,
          width: ScreenUtils().screenWidth(context),
          radius: 10,
        ),
      ],
    );
  }
}
