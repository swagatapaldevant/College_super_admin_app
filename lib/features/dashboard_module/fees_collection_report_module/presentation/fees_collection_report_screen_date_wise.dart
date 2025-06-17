import 'dart:io';

import 'package:college_super_admin_app/core/network/apiHelper/locator.dart';
import 'package:college_super_admin_app/core/network/apiHelper/resource.dart';
import 'package:college_super_admin_app/core/network/apiHelper/status.dart';
import 'package:college_super_admin_app/core/services/localStorage/shared_pref.dart';
import 'package:college_super_admin_app/core/utils/commonWidgets/common_button.dart';
import 'package:college_super_admin_app/core/utils/commonWidgets/custom_button.dart';
import 'package:college_super_admin_app/core/utils/commonWidgets/custom_date_picker.dart';
import 'package:college_super_admin_app/core/utils/commonWidgets/custom_shimmer.dart';
import 'package:college_super_admin_app/core/utils/constants/app_colors.dart';
import 'package:college_super_admin_app/core/utils/helper/common_utils.dart';
import 'package:college_super_admin_app/core/utils/helper/screen_utils.dart';
import 'package:college_super_admin_app/features/dashboard_module/data/dashboard_usecase.dart';
import 'package:college_super_admin_app/features/dashboard_module/fees_collection_report_module/widgets/date_wise_collection_container.dart';
import 'package:college_super_admin_app/features/dashboard_module/models/collect_by_session_model.dart';
import 'package:college_super_admin_app/features/dashboard_module/models/date_wise_course_collection_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import 'fees_collection_report_by_course.dart';

class FeesCollectionReportScreenDateWise extends StatefulWidget {
  const FeesCollectionReportScreenDateWise({super.key});

  @override
  State<FeesCollectionReportScreenDateWise> createState() =>
      _FeesCollectionReportScreenDateWiseState();
}

class _FeesCollectionReportScreenDateWiseState
    extends State<FeesCollectionReportScreenDateWise> {
  String selectedFromDate = "";
  String selectedToDate = "";

  final DashboardUsecase _dashboardUsecase = getIt<DashboardUsecase>();
  final SharedPref _pref = getIt<SharedPref>();
  bool isLoading = false;
  List<CollectBySessionModel> dateWiseCollectionList = [];
  final ScreenshotController _screenshotController = ScreenshotController();
  bool track = false;
  List<DateWiseCourseCollectionModel> sevenDaysCollectionList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: _screenshotController,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    EdgeInsets.all(ScreenUtils().screenWidth(context) * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Hi, Welcome back",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins",
                              color: AppColors.gray7),
                        ),
                        Bounceable(
                          onTap: () async {
                            final image = await _screenshotController.capture();
                            if (image != null) {
                              final directory = await getTemporaryDirectory();
                              final imagePath =
                                  await File('${directory.path}/screenshot.png')
                                      .create();
                              await imagePath.writeAsBytes(image);
                              Share.shareXFiles([XFile(imagePath.path)],
                                  text: '.');
                            }
                          },
                          child: CircleAvatar(
                            backgroundColor: AppColors.gray2,
                            child: Icon(Icons.share, color: AppColors.gray7),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Fees Collection Report Dashboard",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppins",
                          color: AppColors.colorBlack),
                    ),
                    SizedBox(
                      height: ScreenUtils().screenHeight(context) * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Please choose the date range ",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins",
                              color: AppColors.colorBlack),
                        ),
                        selectedFromDate == "" || selectedToDate == "" || sevenDaysCollectionList.isEmpty
                            ? SizedBox.shrink()
                            :
                        CommonButton(
                            onTap: () {
                              CommonDialog(
                                  courseList: sevenDaysCollectionList,
                                  context: context);
                            },
                            height: ScreenUtils().screenHeight(context) * 0.05,
                            width: ScreenUtils().screenWidth(context) * 0.22,
                            buttonName: "Last 7 days\n analysis",
                            fontSize: 10,
                            borderRadius: 5,
                            buttonTextColor: AppColors.white,
                            gradientColor1: AppColors.darkBlue,
                            gradientColor2: AppColors.darkBlue)
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtils().screenHeight(context) * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomDatePickerField(
                          onDateChanged: (String value) {
                            selectedToDate = value;
                            setState(() {
                              track = false;
                            });
                          },
                          placeholderText: 'From date',
                        ),
                        CustomDatePickerField(
                          onDateChanged: (String value) {
                            selectedFromDate = value;
                            setState(() {
                              track = false;
                            });
                          },
                          placeholderText: 'To date',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtils().screenHeight(context) * 0.02,
                    ),
                    selectedFromDate == "" || selectedToDate == ""
                        ? SizedBox.shrink()
                        : CommonButton(
                            onTap: () {
                              setState(() {

                              });
                              getAllFeesCollectionReport();
                            },
                            height: ScreenUtils().screenHeight(context) * 0.045,
                            width: ScreenUtils().screenWidth(context),
                            buttonName: "Submit",
                            fontSize: 14,
                            borderRadius: 10,
                            buttonTextColor: AppColors.white,
                            gradientColor1: AppColors.darkBlue,
                            gradientColor2: AppColors.darkBlue),
                  ],
                ),
              ),
              SizedBox(
                height: ScreenUtils().screenHeight(context) * 0.01,
              ),
              selectedFromDate == "" || selectedToDate == ""
                  ? SizedBox.shrink()
                  : isLoading
                      ? loading()
                      : Expanded(
                          child: dateWiseCollectionList.isEmpty
                              ? Center(
                                  child: track == false
                                      ? Text(
                                          "Please click on submit button",
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              color: AppColors.darkBlue,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14),
                                        )
                                      : Text(
                                          "No data found in this range",
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              color: AppColors.darkBlue,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14),
                                        ),
                                )
                              : GridView.builder(
                                  itemCount: dateWiseCollectionList.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 1.8,
                                          mainAxisSpacing: 0,
                                          crossAxisSpacing: 0,
                                          crossAxisCount: 2),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return DateWiseCollectionContainer(
                                      onTap: () {
                                        Navigator.pushNamed(context,
                                            "/FeesCollectionReportByCourse",
                                            arguments:
                                                dateWiseCollectionList[index]
                                                    .date
                                                    .toString());
                                      },
                                      date: dateWiseCollectionList[index]
                                          .date
                                          .toString(),
                                      weekDay: getWeekdayNameFromString(
                                          dateWiseCollectionList[index]
                                              .date
                                              .toString()),
                                      totalCollection:
                                          dateWiseCollectionList[index]
                                              .totalSum
                                              .toString(),
                                    );
                                  }))
            ],
          ),
        ),
      ),
    );
  }

  getAllFeesCollectionReport() async {
    setState(() {
      isLoading = true;
    });

    Map<String, dynamic> requestData = {
      "from_date": selectedToDate,
      "to_date": selectedFromDate,
      "ret_type": "date_wise"
    };

    Resource resource = await _dashboardUsecase.getAllCollectionBySession(
        requestData: requestData);
    if (resource.status == STATUS.SUCCESS) {
      dateWiseCollectionList = (resource.data as List)
          .map((x) => CollectBySessionModel.fromJson(x))
          .toList();

      sevenDaysCollectionList = dateWiseCollectionList
          .take(7) // or use filter here if needed
          .map((item) => DateWiseCourseCollectionModel(
                courseName: item.date,
                totalSum: item.totalSum,
              ))
          .toList();

      print(sevenDaysCollectionList);

      if (dateWiseCollectionList.isEmpty) {
        track = true;
      }

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

  String getWeekdayNameFromString(String dateString) {
    try {
      DateTime date = DateTime.parse(dateString); // Parses ISO 8601 format
      return DateFormat('EEEE')
          .format(date); // Returns full weekday name like "Monday"
    } catch (e) {
      return 'Invalid date';
    }
  }

  Widget loading() {
    return Expanded(
      child: ListView.builder(
          itemCount: 8,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: ScreenUtils().screenWidth(context) * 0.04,
                left: ScreenUtils().screenWidth(context) * 0.04,
                right: ScreenUtils().screenWidth(context) * 0.04,
              ),
              child: CustomShimmer(
                height: ScreenUtils().screenHeight(context) * 0.07,
                width: ScreenUtils().screenWidth(context),
                radius: 10,
              ),
            );
          }),
    );
  }
}

CommonDialog(
    {required List<DateWiseCourseCollectionModel> courseList,
    required BuildContext context}) {
  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0)), //this right here
          child: Container(
            height: ScreenUtils().screenHeight(context) * 0.5 - 25,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(25.0),
              ),
              color: Theme.of(context).scaffoldBackgroundColor,
              // boxShadow: [
              //   BoxShadow(
              //     // color:  Colors.blueGrey.withOpacity(0.4),
              //       color: AppColors.colorPrimaryText2.withOpacity(0.2),
              //       offset: Offset(0.0, 5.0),
              //       blurRadius: 10.0)
              // ],
            ),
            child: Padding(
              padding:
                  EdgeInsets.all(ScreenUtils().screenWidth(context) * 0.04),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 10,
                children: [
                  Text(
                    "Last 7 days analysis",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins",
                        color: AppColors.colorBlack),
                  ),
                  Text(
                    "Date vs Total collection",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins",
                        color: AppColors.gray7),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.gray7.withOpacity(0.25),
                          blurRadius: 4,
                          offset: const Offset(0, 4),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CourseBarChart(
                        courseList: courseList,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  CommonButton(
                    onTap: (){
                      Navigator.pop(context);
                    },
                      height: ScreenUtils().screenHeight(context)*0.035,
                      width: ScreenUtils().screenWidth(context),
                      buttonName: "Close",
                      fontSize: 12,
                      borderRadius: 10,
                      buttonTextColor: AppColors.white,
                      gradientColor1: AppColors.darkBlue,
                      gradientColor2: AppColors.darkBlue)
                ],
              ),
            ),
          ),
        );
      });
}
