import 'package:college_super_admin_app/core/network/apiHelper/locator.dart';
import 'package:college_super_admin_app/core/network/apiHelper/resource.dart';
import 'package:college_super_admin_app/core/network/apiHelper/status.dart';
import 'package:college_super_admin_app/core/services/localStorage/shared_pref.dart';
import 'package:college_super_admin_app/core/utils/commonWidgets/custom_shimmer.dart';
import 'package:college_super_admin_app/core/utils/constants/app_colors.dart';
import 'package:college_super_admin_app/core/utils/helper/common_utils.dart';
import 'package:college_super_admin_app/core/utils/helper/screen_utils.dart';
import 'package:college_super_admin_app/features/dashboard_module/data/dashboard_usecase.dart';
import 'package:college_super_admin_app/features/dashboard_module/models/homeDashboardNewAdmissionModel.dart';
import 'package:college_super_admin_app/features/dashboard_module/models/home_dashboard_notice_model.dart';
import 'package:college_super_admin_app/features/dashboard_module/widgets/dashboard_small_container.dart';
import 'package:college_super_admin_app/features/dashboard_module/widgets/dashboard_small_progress_section_container.dart';
import 'package:college_super_admin_app/features/dashboard_module/widgets/new_admission_container.dart';
import 'package:flutter/material.dart';

class HomeContainer extends StatefulWidget {
  const HomeContainer({super.key});

  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  final DashboardUsecase _dashboardUsecase = getIt<DashboardUsecase>();
  final SharedPref _pref = getIt<SharedPref>();
  bool isLoading = false;
  List<HomeDashboardNewAdmissionModel> dashboardNewAdmission = [];
  List<HomeDashboardNoticeModel> noticeList = [];
  int totalStudents = 0;
  int totalTeacher = 0;
  int maleCount = 0;
  int femaleCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDashboardData();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: isLoading
          ? loadingWidget()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DashboardSmallContainer(
                      icon: Icons.supervisor_account_sharp,
                      value: totalStudents.toString(),
                      text1: 'total Students',
                      changeValue: '+0.5',
                    ),
                    DashboardSmallContainer(
                      icon: Icons.school,
                      value: totalTeacher.toString(),
                      text1: 'total Teachers',
                      changeValue: '+0.5',
                    ),
                  ],
                ),
                SizedBox(
                  height: ScreenUtils().screenHeight(context) * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DashboardSmallProgressSectionContainer(
                      value: _calculateProgressValue(maleCount, totalStudents),
                      progressBarColor: AppColors.blue,
                      content: 'Male',
                      contentValue: maleCount.toString(),
                    ),
                    DashboardSmallProgressSectionContainer(
                      value:
                          _calculateProgressValue(femaleCount, totalStudents),
                      progressBarColor: AppColors.colorTomato,
                      content: 'Female',
                      contentValue: femaleCount.toString(),
                    ),
                  ],
                ),
                SizedBox(
                  height: ScreenUtils().screenHeight(context) * 0.01,
                ),
                NewAdmissionContainer(
                  studentList: dashboardNewAdmission,
                ),
                SizedBox(
                  height: ScreenUtils().screenHeight(context) * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Container(
                    //   height: ScreenUtils().screenHeight(context) * 0.14,
                    //   width: ScreenUtils().screenWidth(context) * 0.4,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10),
                    //     color: AppColors.dailyStreakColor,
                    //   ),
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(10.0),
                    //     child: Column(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: [
                    //         Text(
                    //           "Auto Generated admission report",
                    //           textAlign: TextAlign.center,
                    //           style: TextStyle(
                    //               fontSize: 14,
                    //               fontFamily: "Poppins",
                    //               fontWeight: FontWeight.w500,
                    //               color: AppColors.white),
                    //         ),
                    //         Align(
                    //             alignment: Alignment.centerRight,
                    //             child: Icon(
                    //               Icons.arrow_forward,
                    //               color: AppColors.white,
                    //               size: 30,
                    //             ))
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    Container(
                      height: ScreenUtils().screenHeight(context) * 0.2,
                      width: ScreenUtils().screenWidth(context) *0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.blue,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Upcoming Notice : ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.white),
                            ),
                            Divider(),
                            Expanded(
                              child:noticeList.isEmpty?Text("No notices are present now", style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins",
                                  color: AppColors.white
                              ),): ListView.builder(
                                  itemCount: noticeList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: EdgeInsets.only(top: 4.0),
                                      child: Text(
                                        "${noticeList[index].publishedOn} ${noticeList[index].subject}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.white),
                                      ),
                                    );
                                  }),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
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
      totalStudents = resource.data["total_student"];
      totalTeacher = resource.data["total_teacher"];
      maleCount = resource.data["maleCount"];
      femaleCount = resource.data["femaleCount"];
      dashboardNewAdmission = (resource.data["new_admission"] as List)
          .map((x) => HomeDashboardNewAdmissionModel.fromJson(x))
          .toList();
      noticeList = (resource.data["notice"] as List)
          .map((x) => HomeDashboardNoticeModel.fromJson(x))
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

  double _calculateProgressValue(int maleCountStr, int totalStr) {
    final male = maleCountStr.toDouble();
    final total = totalStr.toDouble(); // Avoid divide by 0
    print((male / total).toString());
    return male / total;
  }


  Widget loadingWidget(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomShimmer(
              height: ScreenUtils().screenHeight(context) * 0.1,
              width: ScreenUtils().screenWidth(context) * 0.4,
              radius: 10,
            ),
            CustomShimmer(
              height: ScreenUtils().screenHeight(context) * 0.1,
              width: ScreenUtils().screenWidth(context) * 0.4,
              radius: 10,
            ),
          ],
        ),
        SizedBox(
          height: ScreenUtils().screenHeight(context) * 0.01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomShimmer(
              height: ScreenUtils().screenHeight(context) * 0.1,
              width: ScreenUtils().screenWidth(context) * 0.4,
              radius: 10,
            ),
            CustomShimmer(
              height: ScreenUtils().screenHeight(context) * 0.1,
              width: ScreenUtils().screenWidth(context) * 0.4,
              radius: 10,
            ),
          ],
        ),
        SizedBox(
          height: ScreenUtils().screenHeight(context) * 0.02,
        ),
        CustomShimmer(
          height: ScreenUtils().screenHeight(context) * 0.02,
          width: ScreenUtils().screenWidth(context) * 0.3,
          radius: 10,
        ),
        SizedBox(
          height: ScreenUtils().screenHeight(context) * 0.01,
        ),
        CustomShimmer(
          height: ScreenUtils().screenHeight(context) * 0.02,
          width: ScreenUtils().screenWidth(context) * 0.5,
          radius: 10,
        ),
        SizedBox(
          height: ScreenUtils().screenHeight(context) * 0.015,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomShimmer(
              height: ScreenUtils().screenHeight(context) * 0.05,
              width: ScreenUtils().screenHeight(context) * 0.05,
              radius: ScreenUtils().screenHeight(context) * 0.05,
            ),
            CustomShimmer(
              height: ScreenUtils().screenHeight(context) * 0.04,
              width: ScreenUtils().screenWidth(context) * 0.5,
              radius: 10,
            ),
            CustomShimmer(
              height: ScreenUtils().screenHeight(context) * 0.03,
              width: ScreenUtils().screenWidth(context) * 0.25,
              radius: 10,
            ),
          ],
        ),
        SizedBox(
          height: ScreenUtils().screenHeight(context) * 0.01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomShimmer(
              height: ScreenUtils().screenHeight(context) * 0.05,
              width: ScreenUtils().screenHeight(context) * 0.05,
              radius: ScreenUtils().screenHeight(context) * 0.05,
            ),
            CustomShimmer(
              height: ScreenUtils().screenHeight(context) * 0.04,
              width: ScreenUtils().screenWidth(context) * 0.5,
              radius: 10,
            ),
            CustomShimmer(
              height: ScreenUtils().screenHeight(context) * 0.03,
              width: ScreenUtils().screenWidth(context) * 0.25,
              radius: 10,
            ),
          ],
        ),
        SizedBox(
          height: ScreenUtils().screenHeight(context) * 0.01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomShimmer(
              height: ScreenUtils().screenHeight(context) * 0.05,
              width: ScreenUtils().screenHeight(context) * 0.05,
              radius: ScreenUtils().screenHeight(context) * 0.05,
            ),
            CustomShimmer(
              height: ScreenUtils().screenHeight(context) * 0.04,
              width: ScreenUtils().screenWidth(context) * 0.5,
              radius: 10,
            ),
            CustomShimmer(
              height: ScreenUtils().screenHeight(context) * 0.03,
              width: ScreenUtils().screenWidth(context) * 0.25,
              radius: 10,
            ),
          ],
        ),
        SizedBox(
          height: ScreenUtils().screenHeight(context) * 0.01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomShimmer(
              height: ScreenUtils().screenHeight(context) * 0.05,
              width: ScreenUtils().screenHeight(context) * 0.05,
              radius: ScreenUtils().screenHeight(context) * 0.05,
            ),
            CustomShimmer(
              height: ScreenUtils().screenHeight(context) * 0.04,
              width: ScreenUtils().screenWidth(context) * 0.5,
              radius: 10,
            ),
            CustomShimmer(
              height: ScreenUtils().screenHeight(context) * 0.03,
              width: ScreenUtils().screenWidth(context) * 0.25,
              radius: 10,
            ),
          ],
        ),
        SizedBox(
          height: ScreenUtils().screenHeight(context) * 0.012,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomShimmer(
              height: ScreenUtils().screenHeight(context) * 0.05,
              width: ScreenUtils().screenHeight(context) * 0.05,
              radius: ScreenUtils().screenHeight(context) * 0.05,
            ),
            CustomShimmer(
              height: ScreenUtils().screenHeight(context) * 0.04,
              width: ScreenUtils().screenWidth(context) * 0.5,
              radius: 10,
            ),
            CustomShimmer(
              height: ScreenUtils().screenHeight(context) * 0.03,
              width: ScreenUtils().screenWidth(context) * 0.25,
              radius: 10,
            ),
          ],
        ),
        SizedBox(
          height: ScreenUtils().screenHeight(context) * 0.012,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomShimmer(
              height: ScreenUtils().screenHeight(context) * 0.12,
              width: ScreenUtils().screenWidth(context) * 0.45,
              radius:10,
            ),
            CustomShimmer(
              height: ScreenUtils().screenHeight(context) * 0.12,
              width: ScreenUtils().screenWidth(context) * 0.45,
              radius:10,
            ),
          ],
        )
      ],
    );
  }
}
