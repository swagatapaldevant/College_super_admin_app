import 'dart:io';

import 'package:college_super_admin_app/core/network/apiHelper/locator.dart';
import 'package:college_super_admin_app/core/network/apiHelper/resource.dart';
import 'package:college_super_admin_app/core/network/apiHelper/status.dart';
import 'package:college_super_admin_app/core/services/localStorage/shared_pref.dart';
import 'package:college_super_admin_app/core/utils/commonWidgets/custom_dropdown.dart';
import 'package:college_super_admin_app/core/utils/commonWidgets/custom_shimmer.dart';
import 'package:college_super_admin_app/core/utils/constants/app_colors.dart';
import 'package:college_super_admin_app/core/utils/helper/common_utils.dart';
import 'package:college_super_admin_app/core/utils/helper/screen_utils.dart';
import 'package:college_super_admin_app/features/dashboard_module/data/dashboard_usecase.dart';
import 'package:college_super_admin_app/features/dashboard_module/due_report_dashboard_widget/header_section.dart';
import 'package:college_super_admin_app/features/dashboard_module/models/date_wise_course_collection_model.dart';
import 'package:college_super_admin_app/features/dashboard_module/models/date_wise_semester_wise_collection_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class FeesCollectionReportByCourse extends StatefulWidget {
  final String date;
  const FeesCollectionReportByCourse({super.key, required this.date});

  @override
  State<FeesCollectionReportByCourse> createState() =>
      _FeesCollectionReportByCourseState();
}

class _FeesCollectionReportByCourseState
    extends State<FeesCollectionReportByCourse> {
  final DashboardUsecase _dashboardUsecase = getIt<DashboardUsecase>();
  final SharedPref _pref = getIt<SharedPref>();
  bool isLoading = false;
  List<DateWiseCourseCollectionModel> courseList = [];
  Map<String, int> mainCourseMap = {};
  String selectedCourse = '';
  int selectedCourseId = 0;
  int totalSum = 0;
  List<DateWiseSemesterWiseCollectionModel> semesterCollectionList = [];
  final ScreenshotController _screenshotController = ScreenshotController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllCourseWiseFeesCollection();
  }

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: _screenshotController,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  left: ScreenUtils().screenWidth(context) * 0.04,
                  right: ScreenUtils().screenWidth(context) * 0.04,
                  top: ScreenUtils().screenWidth(context) * 0.04),
              child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            HeaderSection(
                              headerName: "Course wise fees collection report",
                            ),
                            Bounceable(
                              onTap: () async {
                                final image =
                                    await _screenshotController.capture();
                                if (image != null) {
                                  final directory =
                                      await getTemporaryDirectory();
                                  final imagePath = await File(
                                          '${directory.path}/screenshot.png')
                                      .create();
                                  await imagePath.writeAsBytes(image);
                                  Share.shareXFiles([XFile(imagePath.path)],
                                      text: '.');
                                }
                              },
                              child: CircleAvatar(
                                backgroundColor: AppColors.gray2,
                                child:
                                    Icon(Icons.share, color: AppColors.gray7),
                              ),
                            ),
                          ],
                        ),
                        isLoading
                            ? loading()
                            :  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: ScreenUtils().screenHeight(context) * 0.01,
                            ),
                            CustomDropdownForAttendance(
                              placeHolderText: selectedCourse.isEmpty
                                  ? 'Select Course'
                                  : selectedCourse,
                              data: mainCourseMap,
                              onValueSelected: (String label, int id) {
                                setState(() {
                                  selectedCourse = label;
                                  selectedCourseId = id;
                                });
                                getTotalSumByCourseId(selectedCourseId, courseList);
                                getAllSemesterWiseFeesCollection();
                              },
                              isDisabled: false,
                            ),
                            SizedBox(
                              height: ScreenUtils().screenHeight(context) * 0.02,
                            ),
                            Container(
                                width: ScreenUtils().screenWidth(context),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: AppColors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.gray7.withOpacity(0.2),
                                      blurRadius: 6,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      ScreenUtils().screenWidth(context) * 0.03),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Course wise collection graph in a day",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.darkBlue,
                                          fontFamily: "Poppins",
                                        ),
                                      ),
                                      CourseBarChart(
                                        courseList: courseList,
                                      ),
                                    ],
                                  ),
                                )),
                            SizedBox(
                              height: ScreenUtils().screenHeight(context) * 0.02,
                            ),
                            Container(
                                width: ScreenUtils().screenWidth(context),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: AppColors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.gray7.withOpacity(0.2),
                                      blurRadius: 6,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      ScreenUtils().screenWidth(context) * 0.03),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text:
                                              'Total Collection of $selectedCourse : \n₹ ',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black87,
                                            fontFamily: "Poppins",
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: totalSum.toString(),
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black87,
                                                  fontFamily: "Poppins",
                                                )),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            ScreenUtils().screenHeight(context) *
                                                0.02,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.alphabetSafeArea,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 5),
                                          child: Text(
                                            "Semester wise collection of $selectedCourse",
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.white),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            ScreenUtils().screenHeight(context) *
                                                0.02,
                                      ),
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: semesterCollectionList.length,
                                          itemBuilder:
                                              (BuildContext context, int index) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                  left: ScreenUtils()
                                                          .screenWidth(context) *
                                                      0.03,
                                                  right: ScreenUtils()
                                                          .screenWidth(context) *
                                                      0.03,
                                                  bottom: ScreenUtils()
                                                          .screenWidth(context) *
                                                      0.03),
                                              child: Bounceable(
                                                onTap: () {
                                                  Navigator.pushNamed(context,
                                                      "/FeesCollectionReportStudents",
                                                      arguments: {
                                                        "paymentDate": widget.date,
                                                        "course_id":
                                                            selectedCourseId,
                                                        "semester_id":
                                                            semesterCollectionList[
                                                                    index]
                                                                .semesterId,
                                                      });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: AppColors.alphabetSafeArea3,
                                                    borderRadius:
                                                        BorderRadius.circular(8),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: AppColors.gray7
                                                            .withOpacity(0.2),
                                                        blurRadius: 6,
                                                        offset: const Offset(0, 4),
                                                      ),
                                                    ],
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: ScreenUtils()
                                                                .screenWidth(
                                                                    context) *
                                                            0.03,
                                                        vertical: ScreenUtils()
                                                                .screenWidth(
                                                                    context) *
                                                            0.02),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      spacing: 5,
                                                      children: [
                                                        RichText(
                                                          text: TextSpan(
                                                            text:
                                                                'Semester Name : ',
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight.w500,
                                                              color: AppColors.colorBlack,
                                                              fontFamily: "Poppins",
                                                            ),
                                                            children: <TextSpan>[
                                                              TextSpan(
                                                                  text: semesterCollectionList[
                                                                          index]
                                                                      .semesterName,
                                                                  style: TextStyle(
                                                                    fontSize: 14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color:AppColors.colorBlack,
                                                                    fontFamily:
                                                                        "Poppins",
                                                                  )),
                                                            ],
                                                          ),
                                                        ),
                                                        RichText(
                                                          text: TextSpan(
                                                            text:
                                                                'Total Collection : ₹ ',
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight.w500,
                                                              color: AppColors.colorBlack,
                                                              fontFamily: "Poppins",
                                                            ),
                                                            children: <TextSpan>[
                                                              TextSpan(
                                                                  text: semesterCollectionList[
                                                                          index]
                                                                      .totalSum
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                    fontSize: 14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: AppColors.colorBlack,
                                                                    fontFamily:
                                                                        "Poppins",
                                                                  )),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          })
                                    ],
                                  ),
                                )),
                            SizedBox(
                              height: ScreenUtils().screenHeight(context) * 0.02,
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  getAllCourseWiseFeesCollection() async {
    setState(() {
      isLoading = true;
    });

    Map<String, dynamic> requestData = {
      "payemnt_date": widget.date,
      "ret_type": "single_date"
    };

    Resource resource = await _dashboardUsecase.getAllCollectionBySession(
        requestData: requestData);
    if (resource.status == STATUS.SUCCESS) {
      courseList = (resource.data as List)
          .map((x) => DateWiseCourseCollectionModel.fromJson(x))
          .toList();

      if (courseList.isNotEmpty) {
        for (var course in courseList) {
          if (!mainCourseMap.containsKey(course.courseId)) {
            mainCourseMap[course.courseName ?? ""] = course.courseId ?? 0;
          }
        }
        selectedCourse = mainCourseMap.keys.toList().first.toString();
        selectedCourseId = mainCourseMap.values.toList().first.toInt();
        totalSum = courseList[0].totalSum!.toInt();
        await getAllSemesterWiseFeesCollection();
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

  int? getTotalSumByCourseId(
      int courseId, List<DateWiseCourseCollectionModel> courseList) {
    for (final course in courseList) {
      final int? id = course.courseId;
      final int? ts = course.totalSum;

      if (id == courseId) {
        totalSum = ts!;
        return totalSum;
      }
    }
    return null; // Course ID not found
  }

  getAllSemesterWiseFeesCollection() async {
    setState(() {
      isLoading = true;
    });

    Map<String, dynamic> requestData = {
      "payemnt_date": widget.date,
      "ret_type": "single_date_with_sem",
      "course_id": selectedCourseId
    };

    Resource resource = await _dashboardUsecase.getAllCollectionBySession(
        requestData: requestData);
    if (resource.status == STATUS.SUCCESS) {
      semesterCollectionList = (resource.data as List)
          .map((x) => DateWiseSemesterWiseCollectionModel.fromJson(x))
          .toList();

      if (semesterCollectionList.isNotEmpty) {
        // for (var course in courseList) {
        //   if (!mainCourseMap.containsKey(course.courseId)) {
        //     mainCourseMap[course.courseName ?? ""] = course.courseId ?? 0;
        //   }
        // }
        // selectedCourse = mainCourseMap.keys.toList().first.toString();
        // selectedCourseId = mainCourseMap.values.toList().first.toInt();
        // totalSum = courseList[0].totalSum!.toInt();
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

  Widget loading() {
    return Column(
      children: [
        CustomShimmer(
          height: ScreenUtils().screenHeight(context) * 0.07,
          width: ScreenUtils().screenWidth(context),
          radius: 10,
        ),
        SizedBox(
          height: ScreenUtils().screenHeight(context) * 0.02,
        ),
        CustomShimmer(
          height: ScreenUtils().screenHeight(context) * 0.4,
          width: ScreenUtils().screenWidth(context),
          radius: 10,
        ),
        SizedBox(
          height: ScreenUtils().screenHeight(context) * 0.02,
        ),
        CustomShimmer(
          height: ScreenUtils().screenHeight(context) * 0.07,
          width: ScreenUtils().screenWidth(context),
          radius: 10,
        ),
        SizedBox(
          height: ScreenUtils().screenHeight(context) * 0.02,
        ),
        CustomShimmer(
          height: ScreenUtils().screenHeight(context) * 0.07,
          width: ScreenUtils().screenWidth(context),
          radius: 10,
        ),
        SizedBox(
          height: ScreenUtils().screenHeight(context) * 0.02,
        ),
        CustomShimmer(
          height: ScreenUtils().screenHeight(context) * 0.07,
          width: ScreenUtils().screenWidth(context),
          radius: 10,
        ),
        SizedBox(
          height: ScreenUtils().screenHeight(context) * 0.02,
        ),
        CustomShimmer(
          height: ScreenUtils().screenHeight(context) * 0.07,
          width: ScreenUtils().screenWidth(context),
          radius: 10,
        ),
      ],
    );
  }
}

class CourseBarChart extends StatelessWidget {
  final List<DateWiseCourseCollectionModel> courseList;

  const CourseBarChart({super.key, required this.courseList});

  double getMaxY(List<DateWiseCourseCollectionModel> list) {
    final max = list.map((e) => e.totalSum).reduce((a, b) => a! > b! ? a : b);
    return max! * 1.2;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: BarChart(
        BarChartData(
          maxY: getMaxY(courseList),
          barGroups: List.generate(courseList.length, (index) {
            final item = courseList[index];
            return BarChartGroupData(
              x: index,
              barsSpace: 8,
              barRods: [
                BarChartRodData(
                  toY: item.totalSum!.toDouble(),
                  width: 15,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(6),
                      topLeft: Radius.circular(6)),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.alphabetSafeArea,
                      AppColors.alphabetSafeArea1,
                      AppColors.alphabetSafeArea2,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ],
            );
          }),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) {
                  final int index = value.toInt();
                  if (index >= courseList.length) return const SizedBox();
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Transform.rotate(
                      angle: 45 * 3.1415926535 / 180,
                      child: Text(
                        courseList[index].courseName.toString().length > 12
                            ? courseList[index]
                                .courseName
                                .toString()
                                .substring(0, 12)
                            : courseList[index].courseName.toString(),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Poppins",
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(
            show: false,
            drawHorizontalLine: true,
            getDrawingHorizontalLine: (value) => FlLine(
              color: Colors.grey.withOpacity(0.2),
              strokeWidth: 1,
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: const Border(
              bottom: BorderSide(color: Colors.black12),
            ),
          ),
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  '${courseList[groupIndex].courseName}\n₹ ${rod.toY.toStringAsFixed(0)}',
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins",
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
