import 'package:college_super_admin_app/core/utils/constants/app_colors.dart';
import 'package:college_super_admin_app/core/utils/helper/screen_utils.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CourseRevenueContainer extends StatefulWidget {
  const CourseRevenueContainer({super.key});

  @override
  State<CourseRevenueContainer> createState() => _CourseRevenueContainerState();
}

class _CourseRevenueContainerState extends State<CourseRevenueContainer> {
  String selectedCourse = 'BBA';

  final Map<String, List<FlSpot>> courseData = {
    'BBA': [
      FlSpot(0, 125),
      FlSpot(1, 220),
      FlSpot(2, 360),
      FlSpot(3, 440),
      FlSpot(4, 565),
      FlSpot(5, 645),
      FlSpot(6, 780),
      FlSpot(7, 180),
      FlSpot(8, 478),
      FlSpot(9, 780),
      FlSpot(10, 580),
      FlSpot(11, 280),
    ],
    'BCA': [
      FlSpot(0, 130),
      FlSpot(1, 240),
      FlSpot(2, 335),
      FlSpot(3, 460),
      FlSpot(4, 550),
      FlSpot(5, 760),
      FlSpot(6, 675),
      FlSpot(7, 175),
      FlSpot(8, 575),
      FlSpot(9, 675),
      FlSpot(10, 175),
      FlSpot(11, 675),
    ],
    'BCA Computer science': [
      FlSpot(0, 130),
      FlSpot(1, 240),
      FlSpot(2, 335),
      FlSpot(3, 460),
      FlSpot(4, 650),
      FlSpot(5, 760),
      FlSpot(6, 675),
      FlSpot(7, 175),
      FlSpot(8, 505),
      FlSpot(9, 675),
      FlSpot(10, 575),
      FlSpot(11, 675),
    ],
  };

  final List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        width: ScreenUtils().screenWidth(context),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
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
          padding: EdgeInsets.all(ScreenUtils().screenWidth(context) * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and Dropdown
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Course Name: $selectedCourse',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      customButton: const Icon(Icons.edit),
                      items: courseData.keys.map((course) {
                        return DropdownMenuItem<String>(
                          value: course,
                          child: Text(
                            course,
                            // overflow: TextOverflow.ellipsis,
                            // maxLines: 1,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }).toList(),
                      value: selectedCourse,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedCourse = value;
                          });
                        }
                      },
                      dropdownStyleData: DropdownStyleData(
                        // maxHeight: ScreenUtils().,
                        width: ScreenUtils().screenWidth(context) * 0.5,
                        padding: const EdgeInsets.all(8),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: ScreenUtils().screenHeight(context) * 0.02,
              ),

              // Graph container
              AspectRatio(
                aspectRatio: 1,
                child: LineChart(
                  LineChartData(
                    minY: 0,
                    maxY: 1000,
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, _) {
                            final index = value.toInt();
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                months[index % months.length],
                                style: const TextStyle(fontSize: 10),
                              ),
                            );
                          },
                          interval: 1,
                        ),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    gridData: FlGridData(
                      show: false,
                      drawVerticalLine: true,
                    ),
                    borderData: FlBorderData(
                      show: false,
                      border: Border.all(
                        color: Colors.black12,
                      ),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: courseData[selectedCourse] ?? [],
                        isCurved: true,
                        color: AppColors.progressBarColor,
                        barWidth: 2,
                        isStrokeCapRound: true,
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            colors: [
                              AppColors.progressBarColor.withOpacity(0.7),
                              AppColors.colorSkyBlue300.withOpacity(0.05),

                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),

                        ),
                        dotData: FlDotData(
                          show: true,
                          getDotPainter: (spot, percent, bar, index) =>
                              FlDotCirclePainter(
                            radius: 3,
                            color:AppColors.progressBarColor,
                            strokeWidth: 2,
                            strokeColor:AppColors.progressBarColor,
                          ),
                        ),
                      ),
                    ],
                    lineTouchData: LineTouchData(
                      touchTooltipData: LineTouchTooltipData(
                        tooltipRoundedRadius: 8,
                        getTooltipItems: (spots) {
                          return spots.map((spot) {
                            final month = months[spot.x.toInt()];
                            return LineTooltipItem(
                              '$month\n$selectedCourse: ${spot.y.toInt()}',
                              const TextStyle(color: Colors.white),
                            );
                          }).toList();
                        },
                      ),
                    ),
                  ),
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeInOut,
                ),
              ),
            ],
          ),
        ));
  }
}
