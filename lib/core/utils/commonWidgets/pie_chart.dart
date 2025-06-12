import 'package:college_super_admin_app/core/utils/constants/app_colors.dart';
import 'package:college_super_admin_app/core/utils/helper/screen_utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomPieChart extends StatefulWidget {
  final double paidAmount;
  final double dueAmount;
  final double? containerHeight;
  final double? pieChartHeight;
  final double? pieChartWidth;
  const CustomPieChart({super.key, required this.paidAmount, required this.dueAmount, this.containerHeight, this.pieChartHeight, this.pieChartWidth});

  @override
  State<CustomPieChart> createState() => _CustomPieChartState();
}

class _CustomPieChartState extends State<CustomPieChart> {
  // final double presentPercentage = 75; // Example data
  // final double absentPercentage = 25;  // Example data

  @override
  Widget build(BuildContext context) {
    return Container(
      height:widget.containerHeight?? ScreenUtils().screenHeight(context) * 0.25,
      width: ScreenUtils().screenWidth(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.gray7.withOpacity(0.25),
            blurRadius: 4,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(ScreenUtils().screenWidth(context) * 0.045),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width:widget.pieChartWidth ??ScreenUtils().screenWidth(context) * 0.45,
                  height:widget.pieChartHeight?? ScreenUtils().screenHeight(context) * 0.2,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 1,
                      centerSpaceRadius: ScreenUtils().screenWidth(context) * 0.06,
                      sections: _getPieSections(),
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLegend("Paid amount", widget.paidAmount, Colors.green),
                    SizedBox(height: ScreenUtils().screenWidth(context) * 0.02),
                    _buildLegend("Due amount", widget.dueAmount, Colors.red),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _getPieSections() {
    return [
      PieChartSectionData(
        color: Colors.green,
        value: widget.paidAmount,
        //title: "${presentPercentage.toStringAsFixed(0)}%",
        radius: ScreenUtils().screenWidth(context) * 0.15,
        titleStyle: TextStyle(
            fontSize: ScreenUtils().screenWidth(context) * 0.03,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontFamily: "Poppins"
        ),
        showTitle: false,
      ),
      PieChartSectionData(
        color: Colors.red,
        value: widget.dueAmount,
       // title: "${absentPercentage.toStringAsFixed(0)}%",
        radius: ScreenUtils().screenWidth(context) * 0.15,
        titleStyle: TextStyle(
            fontSize: ScreenUtils().screenWidth(context) * 0.03,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontFamily: "Poppins"
        ),
        showTitle: false,
      ),
    ];
  }

  Widget _buildLegend(String label, double percentage, Color color) {
    return Row(
      children: [
        Container(
          width: ScreenUtils().screenWidth(context) * 0.03,
          height: ScreenUtils().screenWidth(context) * 0.03,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: ScreenUtils().screenWidth(context) * 0.03),
        Text(
          label,
          style: TextStyle(
              fontSize: ScreenUtils().screenWidth(context) * 0.03,
              fontWeight: FontWeight.w500,
            fontFamily: "Poppins",
          ),
        ),
      ],
    );
  }
}