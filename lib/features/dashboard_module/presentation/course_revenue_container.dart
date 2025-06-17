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
import 'package:college_super_admin_app/features/dashboard_module/models/get_course_list_model.dart';
import 'package:college_super_admin_app/features/dashboard_module/models/revenue_model_by_course.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CourseRevenueContainer extends StatefulWidget {
  const CourseRevenueContainer({super.key});

  @override
  State<CourseRevenueContainer> createState() => _CourseRevenueContainerState();
}

class _CourseRevenueContainerState extends State<CourseRevenueContainer> {
  String selectedCourseLabel = '';
  final DashboardUsecase _dashboardUsecase = getIt<DashboardUsecase>();
  final SharedPref _pref = getIt<SharedPref>();
  bool isLoading = false;
  List<GetCourseListModel> getCourseList = [];
  Map<String, int> getCourseListMap = {};
  List<RevenueModelByCourse> monthlyRevenueList = [];

  List<String> months = [];
  List<FlSpot> lineSpots = [];

  @override
  void initState() {
    super.initState();
    getAllCourseName();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Column(
            children: [
              CustomShimmer(
                height: ScreenUtils().screenHeight(context) * 0.05,
                width: ScreenUtils().screenWidth(context),
                radius: 10,
              ),
              SizedBox(
                height: ScreenUtils().screenHeight(context) * 0.02,
              ),
              CustomShimmer(
                height: ScreenUtils().screenHeight(context) * 0.3,
                width: ScreenUtils().screenWidth(context),
                radius: 10,
              ),
            ],
          )
        : Container(
            width: ScreenUtils().screenWidth(context),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: AppColors.gray7.withOpacity(0.25),
                  blurRadius: 4,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding:
                  EdgeInsets.all(ScreenUtils().screenWidth(context) * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomDropdownForAttendance(
                    placeHolderText: selectedCourseLabel.isEmpty
                        ? 'Select Class'
                        : selectedCourseLabel,
                    data: getCourseListMap,
                    onValueSelected: (String label, int id) {
                      setState(() {
                        selectedCourseLabel = label;
                      });
                      getRevenueByCourse(id.toString());
                    },
                    isDisabled: false,
                  ),
                  SizedBox(height: ScreenUtils().screenHeight(context) * 0.02),
                  lineSpots.isNotEmpty
                      ? AspectRatio(
                          aspectRatio: 1.4,
                          child: LineChart(
                            LineChartData(
                              minY: 0,
                              maxY: (lineSpots
                                          .map((e) => e.y)
                                          .reduce((a, b) => a > b ? a : b) *
                                      1.2)
                                  .ceilToDouble(),
                              titlesData: FlTitlesData(
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    interval: 1,
                                    getTitlesWidget: (value, _) {
                                      final index = value.toInt();
                                      if (index >= 0 && index < months.length) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            top: 8.0,
                                          ),
                                          child: Transform.rotate(
                                            angle: 45 * 3.1415926535 / 180,
                                            child: Text(
                                              months[index].length > 3
                                                  ? months[index]
                                                      .substring(0, 3)
                                                  : months[index],
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.black87),
                                            ),
                                          ),
                                        );
                                      }
                                      return const SizedBox.shrink();
                                    },
                                  ),
                                ),
                                topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                              ),
                              gridData: FlGridData(show: false),
                              borderData: FlBorderData(show: false),
                              clipData: FlClipData.all(),
                              lineBarsData: [
                                LineChartBarData(
                                  spots: lineSpots,
                                  isCurved: true,
                                  color: AppColors.progressBarColor,
                                  barWidth: 3,
                                  isStrokeCapRound: true,
                                  belowBarData: BarAreaData(
                                    show: true,
                                    gradient: LinearGradient(
                                      colors: [
                                        AppColors.progressBarColor
                                            .withOpacity(0.7),
                                        AppColors.colorSkyBlue300
                                            .withOpacity(0.05),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                  dotData: FlDotData(
                                    show: true,
                                    getDotPainter:
                                        (spot, percent, bar, index) =>
                                            FlDotCirclePainter(
                                      radius: 4,
                                      color: Colors.white,
                                      strokeWidth: 2,
                                      strokeColor: AppColors.progressBarColor,
                                    ),
                                  ),
                                ),
                              ],
                              lineTouchData: LineTouchData(
                                handleBuiltInTouches: true,
                                touchTooltipData: LineTouchTooltipData(
                                  tooltipRoundedRadius: 8,
                                  getTooltipItems: (spots) {
                                    return spots.map((spot) {
                                      final index = spot.x.toInt();
                                      final month =
                                          index >= 0 && index < months.length
                                              ? months[index]
                                              : 'Unknown';
                                      return LineTooltipItem(
                                        '$month\n₹${spot.y.toInt()}',
                                        const TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.bold),
                                      );
                                    }).toList();
                                  },
                                ),
                              ),
                            ),
                            duration: const Duration(milliseconds: 700),
                            curve: Curves.easeOutCubic,
                          ),
                        )
                      : Center(
                          child: Text(
                          'Select a course to view monthly revenue chart',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins",
                              color: AppColors.colorBlack),
                        )),
                  SizedBox(height: ScreenUtils().screenHeight(context) * 0.02),
                  lineSpots.isNotEmpty? Text("Monthly course wise collection graph ", style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Poppins",
                    color: AppColors.colorBlack,
                    fontWeight: FontWeight.w500

                  ),):SizedBox.shrink()
                ],
              ),
            ),
          );
  }

  Future<void> getAllCourseName() async {
    setState(() => isLoading = true);
    Resource resource = await _dashboardUsecase.getCourseList(requestData: {});
    if (resource.status == STATUS.SUCCESS) {
      getCourseList = (resource.data as List)
          .map((x) => GetCourseListModel.fromJson(x))
          .toList();
      for (var item in getCourseList) {
        if (item.id != null) {
          getCourseListMap[(item.courseName ?? '').trim()] = item.id!;
        }
      }
    } else {
      CommonUtils().flutterSnackBar(
        context: context,
        mes: resource.message ?? '',
        messageType: 4,
      );
    }
    setState(() => isLoading = false);
  }

  Future<void> getRevenueByCourse(String id) async {
    setState(() {
      isLoading = true;
      lineSpots.clear();
      months.clear();
    });

    Resource resource = await _dashboardUsecase.courseRevenueByCourse(
      requestData: {},
      courseId: id,
    );

    if (resource.status == STATUS.SUCCESS) {
      monthlyRevenueList = (resource.data as List)
          .map((x) => RevenueModelByCourse.fromJson(x))
          .toList();

      for (int i = 0; i < monthlyRevenueList.length; i++) {
        final item = monthlyRevenueList[i];
        months.add(item.month ?? '');
        lineSpots.add(FlSpot(i.toDouble(), item.total?.toDouble() ?? 0.0));
      }
    } else {
      CommonUtils().flutterSnackBar(
        context: context,
        mes: resource.message ?? '',
        messageType: 4,
      );
    }

    setState(() => isLoading = false);
  }
}
