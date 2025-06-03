import 'package:college_super_admin_app/core/utils/constants/app_colors.dart';
import 'package:college_super_admin_app/core/utils/helper/screen_utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AdmissionResultEveryMonthContainer extends StatefulWidget {
  final List<String> weekDays;
  final List<int> blueData;
  // final List<int> redData;
  final String text;

  const AdmissionResultEveryMonthContainer(
      {super.key,
      required this.weekDays,
      required this.blueData,
      // required this.redData,
      required this.text});

  @override
  State<AdmissionResultEveryMonthContainer> createState() =>
      _AdmissionResultEveryMonthContainerState();
}

class _AdmissionResultEveryMonthContainerState
    extends State<AdmissionResultEveryMonthContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: ScreenUtils().screenHeight(context) * 0.4,
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
        padding: EdgeInsets.all(
          ScreenUtils().screenWidth(context) * 0.04,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.text,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.colorBlack),
            ),
            SizedBox(
              height: ScreenUtils().screenHeight(context) * 0.02,
            ),
            AdmissionResultBarChartDetails(
              weekDays: widget.weekDays,
              blueData: widget.blueData,
              //redData: widget.redData,
            ),
            SizedBox(
              height: ScreenUtils().screenHeight(context) * 0.01,
            ),
            // Row(
            //   spacing: 10,
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     Row(
            //       spacing: 5,
            //       children: [
            //         CircleAvatar(
            //           radius: 5,
            //           backgroundColor: AppColors.blue,
            //         ),
            //         Text(
            //           "Others",
            //           style: TextStyle(
            //               fontWeight: FontWeight.w500,
            //               color: AppColors.colorBlack,
            //               fontSize: 12),
            //         )
            //       ],
            //     ),
            //     Row(
            //       spacing: 5,
            //       children: [
            //         CircleAvatar(
            //           radius: 5,
            //           backgroundColor: AppColors.progressBarColor,
            //         ),
            //         Text(
            //           "Cash",
            //           style: TextStyle(
            //               fontWeight: FontWeight.w500,
            //               color: AppColors.colorBlack,
            //               fontSize: 12),
            //         )
            //       ],
            //     )
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}

class AdmissionResultBarChartDetails extends StatefulWidget {
  final List<String> weekDays;
  final List<int> blueData;
  //final List<double> redData;
  const AdmissionResultBarChartDetails({
    super.key,
    required this.weekDays,
    required this.blueData,
    //required this.redData
  });

  @override
  _AdmissionResultBarChartDetailsState createState() =>
      _AdmissionResultBarChartDetailsState();
}

class _AdmissionResultBarChartDetailsState
    extends State<AdmissionResultBarChartDetails> {
  List<int> currentBlue = List.filled(12, 0);
  //List<double> currentRed = List.filled(12, 0);

  @override
  void initState() {
    super.initState();
    animateBars();
  }

  void animateBars() async {
    for (int i = 0; i < widget.blueData.length; i++) {
      await Future.delayed(const Duration(milliseconds: 200));
      setState(() {
        currentBlue[i] = widget.blueData[i];
        //currentRed[i] = widget.redData[i];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.4,
      child: BarChart(
        BarChartData(
          maxY: getMaxY(widget.blueData.map((e) => e.toDouble()).toList()),
          barGroups: List.generate(widget.weekDays.length, (index) {
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: currentBlue[index].toDouble(),
                  width: 8,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(6),
                      topLeft: Radius.circular(6)),
                  gradient: LinearGradient(
                    colors: [AppColors.blue, Color(0xFF1E88E5)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                // BarChartRodData(
                //   toY: currentRed[index],
                //   width: 8,
                //   borderRadius: BorderRadius.only(
                //       topRight: Radius.circular(6),
                //       topLeft: Radius.circular(6)),
                //   gradient: LinearGradient(
                //     colors: [AppColors.progressBarColor, AppColors.colorGreen],
                //     begin: Alignment.bottomCenter,
                //     end: Alignment.topCenter,
                //   ),
                // ),
              ],
              barsSpace: 0,
            );
          }),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                //reservedSize: 32,
                getTitlesWidget: (value, _) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: ScreenUtils().screenHeight(context) * 0.01),
                    child: Transform.rotate(
                      angle: 45 * 3.1415926535 / 180,
                      child: Text(
                        widget.weekDays[value.toInt()],
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(
            show: true,
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
                  rod.toY.toStringAsFixed(1),
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  double getMaxY(List<double> allValues) {
    if (allValues.isEmpty) return 10;
    double maxVal = allValues.reduce((a, b) => a > b ? a : b);
    return (maxVal * 1.2).ceilToDouble(); // add 20% padding
  }
}
