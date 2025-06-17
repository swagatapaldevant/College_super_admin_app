import 'dart:io';

import 'package:college_super_admin_app/core/network/apiHelper/locator.dart';
import 'package:college_super_admin_app/core/network/apiHelper/resource.dart';
import 'package:college_super_admin_app/core/network/apiHelper/status.dart';
import 'package:college_super_admin_app/core/services/localStorage/shared_pref.dart';
import 'package:college_super_admin_app/core/utils/commonWidgets/common_dialog.dart';
import 'package:college_super_admin_app/core/utils/commonWidgets/custom_3d_piechart.dart';
import 'package:college_super_admin_app/core/utils/commonWidgets/custom_shimmer.dart';
import 'package:college_super_admin_app/core/utils/constants/app_colors.dart';
import 'package:college_super_admin_app/core/utils/helper/common_utils.dart';
import 'package:college_super_admin_app/core/utils/helper/screen_utils.dart';
import 'package:college_super_admin_app/features/dashboard_module/data/dashboard_usecase.dart';
import 'package:college_super_admin_app/features/dashboard_module/due_report_dashboard_widget/due_report_dashboard_container.dart';
import 'package:college_super_admin_app/features/dashboard_module/due_report_dashboard_widget/paid_due_amount_container.dart';
import 'package:college_super_admin_app/features/dashboard_module/models/session_list_model.dart';
import 'package:college_super_admin_app/features/dashboard_module/widgets/dashboard_small_progress_section_container.dart';
import 'package:college_super_admin_app/features/dashboard_module/widgets/header_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/utils/commonWidgets/dashboard_pie_chart.dart';

class DueReportDashboardScreenDetails extends StatefulWidget {
  const DueReportDashboardScreenDetails({super.key});

  @override
  State<DueReportDashboardScreenDetails> createState() =>
      _DueReportDashboardScreenDetailsState();
}

class _DueReportDashboardScreenDetailsState
    extends State<DueReportDashboardScreenDetails> {
  final SharedPref _pref = getIt<SharedPref>();
  final DashboardUsecase _dashboardUsecase = getIt<DashboardUsecase>();
  final ScreenshotController _screenshotController = ScreenshotController();

  String imgUrl = "";
  String userNme = "";
  bool isLoading = false;

  List<SessionListModel> sessionList = [];
  Map<int, int> sessionMap = {};
  int? currentSessionId;
  String? selectedKey;

  double totalAmount = 0.0;
  double amountPaid = 0.0;
  double dueAmount = 0.0;
  double scholarshipAmount = 0.0;
  double concessionAmount = 0.0;
  double totalAmountBeforeDiscount = 0.0;

  @override
  void initState() {
    super.initState();
    getLocalData();
    fetchInitialSessionData();
  }

  Future<void> getLocalData() async {
    try {
      final image = await _pref.getProfileImage();
      final userName = await _pref.getUserName();
      setState(() {
        imgUrl =
            "https://plus.unsplash.com/premium_photo-1689568126014-06fea9d5d341?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D";
        userNme = userName ?? "";
      });
    } catch (e) {
      print('Error loading local data: $e');
    }
  }

  Future<void> fetchInitialSessionData() async {
    setState(() => isLoading = true);

    final settingsResponse =
        await _dashboardUsecase.getErpSettings(requestData: {});
    if (settingsResponse.status == STATUS.SUCCESS) {
      currentSessionId = settingsResponse.data['session_id'];
      await getSessionList();
      await getAllDueData();
    } else {
      CommonUtils().flutterSnackBar(
          context: context,
          mes: settingsResponse.message ?? "Something went wrong",
          messageType: 4);
    }

    setState(() => isLoading = false);
  }

  Future<void> getSessionList() async {
    final sessionResponse =
        await _dashboardUsecase.getSessionList(requestData: {});

    if (sessionResponse.status == STATUS.SUCCESS) {
      final data = sessionResponse.data as List;
      sessionList = data.map((e) => SessionListModel.fromJson(e)).toList();

      sessionMap.clear();
      for (var item in sessionList) {
        if (item.id != null && item.name != null) {
          sessionMap[item.id!] = item.name ?? 0;
        }
      }

      if (currentSessionId != null &&
          sessionMap.containsKey(currentSessionId)) {
        selectedKey = currentSessionId!.toString();
      }

      setState(() {}); // Only update UI after everything is ready
    } else {
      CommonUtils().flutterSnackBar(
          context: context,
          mes: sessionResponse.message ?? "Unable to fetch sessions",
          messageType: 4);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: _screenshotController,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtils().screenWidth(context) * 0.04,
                vertical: ScreenUtils().screenWidth(context) * 0.02,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // CircleAvatar(
                      //   backgroundColor: AppColors.gray2,
                      //   child: Icon(Icons.notifications_active,
                      //       color: AppColors.gray7),
                      // ),
                      SizedBox(width: 8),
                      HeaderSection(imgUrl: imgUrl, name: userNme),
                      SizedBox(width: 8),
                      Bounceable(
                        onTap: () async{
                          final image = await _screenshotController.capture();
                          if (image != null) {
                            final directory = await getTemporaryDirectory();
                            final imagePath = await File('${directory.path}/screenshot.png').create();
                            await imagePath.writeAsBytes(image);
                            Share.shareXFiles([XFile(imagePath.path)], text: '.');
                          }
                        },
                        child: CircleAvatar(
                          backgroundColor: AppColors.gray2,
                          child: Icon(Icons.share, color: AppColors.gray7),
                        ),
                      ),
                      SizedBox(width: 8),
                      Bounceable(
                        onTap: () {
                          CommonDialog(
                            icon: Icons.logout,
                            title: "Log Out",
                            msg:
                                "You are about to logout of your account. Please confirm.",
                            activeButtonLabel: "Log Out",
                            context: context,
                            activeButtonOnClicked: () {
                              _pref.clearOnLogout();
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                "/SigninScreen",
                                (route) => false,
                              );
                            },
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor: AppColors.gray2,
                          child: Icon(Icons.logout, color: AppColors.darkBlue),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: ScreenUtils().screenHeight(context) * 0.01),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     Text(
                  //       "Share",
                  //       style: TextStyle(
                  //         fontSize: 14,
                  //         fontWeight: FontWeight.w600,
                  //         color: AppColors.gray7,
                  //       ),
                  //     ),
                  //     SizedBox(width: 10,),
                  //     Icon(Icons.share)
                  //   ],
                  // ),

                  isLoading
                      ? loading()
                      : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hi, Welcome back",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.gray7,
                                        fontFamily: "Poppins"),
                                  ),
                                  Text(
                                    "Due Report Dashboard",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.colorBlack,
                                        fontFamily: "Poppins"),
                                  ),

                                ],
                              ),
                              Container(
                                width:
                                    ScreenUtils().screenWidth(context) * 0.3,
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: selectedKey,
                                    icon: Icon(Icons.arrow_drop_down),
                                    borderRadius: BorderRadius.circular(12),
                                    isExpanded: true,
                                    items: sessionMap.entries.map((entry) {
                                      return DropdownMenuItem<String>(
                                        value: entry.key.toString(),
                                        child: Text(
                                          entry.value.toString(),
                                          style: TextStyle(
                                              color: AppColors.colorBlack,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Poppins"),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedKey = value;
                                        currentSessionId =
                                            int.parse(selectedKey ?? "");
                                        print(selectedKey);
                                        getAllDueData();
                                      });
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                              height:
                                  ScreenUtils().screenHeight(context) * 0.02),
                          DueReportDashboardContainer(
                            valuefontsize: 12,
                            iconfontsize: 18,
                            fontsize: 12,
                            icon: Icons.monetization_on,
                            value: totalAmountBeforeDiscount.toString(),
                            text1: 'Total amount(Before Discount)',
                            containerWidth:
                                ScreenUtils().screenWidth(context),
                          ),
                          SizedBox(
                              height:
                                  ScreenUtils().screenHeight(context) * 0.01),
                          DueReportDashboardContainer(
                            valuefontsize: 12,
                            iconfontsize: 18,
                            fontsize: 12,
                            icon: Icons.monetization_on,
                            value: totalAmount.toString(),
                            text1: 'Total amount(After discount)',
                            containerWidth:
                                ScreenUtils().screenWidth(context),
                          ),
                          SizedBox(
                              height:
                                  ScreenUtils().screenHeight(context) * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              PaidDueAmountContainer(
                                textfonsize: 11,
                                valuefonsize: 11,
                                value: divideStrings(amountPaid, totalAmount),
                                progressBarColor:  Colors.green,
                                content: 'Total Paid\namount',
                                contentValue: amountPaid.toString(),
                              ),
                              PaidDueAmountContainer(
                                textfonsize: 11,
                                valuefonsize: 11,
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, "/CourseWiseDueReportScreen",
                                      arguments: currentSessionId);
                                },
                                value: divideStrings(dueAmount, totalAmount),
                                color: AppColors.alphabetSafeArea3,
                                progressBarColor: AppColors.colorTomato,
                                content: 'Total Due\namount',
                                contentValue: dueAmount.toString(),
                              ),
                            ],
                          ),
                          SizedBox(
                              height:
                                  ScreenUtils().screenHeight(context) * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              PaidDueAmountContainer(
                                textfonsize: 11,
                                valuefonsize: 11,
                                value: divideStrings(
                                    scholarshipAmount, totalAmount),
                                progressBarColor: AppColors.progressBarColor.withOpacity(0.6),
                                content: 'Scholarship \namount',
                                contentValue: scholarshipAmount.toString(),
                              ),
                              PaidDueAmountContainer(
                                textfonsize: 11,
                                valuefonsize: 11,
                                value: divideStrings(
                                    concessionAmount, totalAmount),
                                progressBarColor: AppColors.alphabetSafeArea,
                                content: 'Concession \namount',
                                contentValue: concessionAmount.toString(),
                              ),
                            ],
                          ),
                          SizedBox(
                              height:
                                  ScreenUtils().screenHeight(context) * 0.02),
                          CustomPieChartForDashboard(
                            paidAmount: amountPaid,
                            dueAmount: dueAmount,
                            scholarshipAmount: scholarshipAmount,
                            concessionAmount: concessionAmount,
                            totalAmountBeforeDiscount:
                                totalAmountBeforeDiscount,
                          ),
                        ],
                      )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  getAllDueData() async {
    setState(() {
      isLoading = true;
    });

    Map<String, dynamic> requestData = {
      "session_id": currentSessionId,
      "data_type": "session"
    };

    Resource resource =
        await _dashboardUsecase.getAllDueData(requestData: requestData);

    if (resource.status == STATUS.SUCCESS) {
      totalAmount = double.parse(resource.data["total_amount"].toString()) -
          double.parse(resource.data["scholarship_amount"].toString()) -
          double.parse(resource.data["concession_amount"].toString());
      totalAmountBeforeDiscount =
          double.parse(resource.data["total_amount"].toString());
      amountPaid = double.parse(resource.data["amount_paid"].toString());
      dueAmount = double.parse(resource.data["due_amount"].toString());
      scholarshipAmount =
          double.parse(resource.data["scholarship_amount"].toString());
      concessionAmount =
          double.parse(resource.data["concession_amount"].toString());

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

  double divideStrings(double numeratorStr, double denominatorStr) {
    try {
      double numerator = numeratorStr;
      double denominator = denominatorStr;
      if (denominator == 0) {
        throw ArgumentError('Division by zero is not allowed.');
      }
      return numerator / denominator;
    } catch (e) {
      print('Error: $e');
      return 0.0; // or you can choose to rethrow the exception
    }
  }

  Widget loading() {
    return Column(
      children: [
        CustomShimmer(
          height: ScreenUtils().screenHeight(context) * 0.08,
          width: ScreenUtils().screenWidth(context),
          radius: 10,
        ),
        SizedBox(
          height: ScreenUtils().screenHeight(context) * 0.02,
        ),
        CustomShimmer(
          height: ScreenUtils().screenHeight(context) * 0.06,
          width: ScreenUtils().screenWidth(context),
          radius: 10,
        ),
        SizedBox(
          height: ScreenUtils().screenHeight(context) * 0.01,
        ),
        CustomShimmer(
          height: ScreenUtils().screenHeight(context) * 0.06,
          width: ScreenUtils().screenWidth(context),
          radius: 10,
        ),
        SizedBox(
          height: ScreenUtils().screenHeight(context) * 0.01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomShimmer(
              height: ScreenUtils().screenHeight(context) * 0.08,
              width: ScreenUtils().screenWidth(context) * 0.4,
              radius: 10,
            ),
            CustomShimmer(
              height: ScreenUtils().screenHeight(context) * 0.08,
              width: ScreenUtils().screenWidth(context) * 0.4,
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
              height: ScreenUtils().screenHeight(context) * 0.08,
              width: ScreenUtils().screenWidth(context) * 0.4,
              radius: 10,
            ),
            CustomShimmer(
              height: ScreenUtils().screenHeight(context) * 0.08,
              width: ScreenUtils().screenWidth(context) * 0.4,
              radius: 10,
            ),
          ],
        ),
        SizedBox(
          height: ScreenUtils().screenHeight(context) * 0.01,
        ),
        CustomShimmer(
          height: ScreenUtils().screenHeight(context) * 0.4,
          width: ScreenUtils().screenWidth(context),
          radius: 10,
        ),
      ],
    );
  }
}
