import 'package:college_super_admin_app/core/utils/constants/app_colors.dart';
import 'package:college_super_admin_app/core/utils/helper/screen_utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomPieChartForDashboard extends StatefulWidget {
  final double paidAmount;
  final double dueAmount;
  final double scholarshipAmount;
  final double concessionAmount;
  final double totalAmountBeforeDiscount;
  final double? containerHeight;
  final double? pieChartHeight;
  final double? pieChartWidth;
  const CustomPieChartForDashboard({super.key, required this.paidAmount, required this.dueAmount, this.containerHeight, this.pieChartHeight, this.pieChartWidth, required this.scholarshipAmount, required this.concessionAmount, required this.totalAmountBeforeDiscount});

  @override
  State<CustomPieChartForDashboard> createState() => _CustomPieChartForDashboardState();
}

class _CustomPieChartForDashboardState extends State<CustomPieChartForDashboard> {
  // final double presentPercentage = 75; // Example data
  // final double absentPercentage = 25;  // Example data

  @override
  Widget build(BuildContext context) {
    return Container(
      //height:widget.containerHeight?? ScreenUtils().screenHeight(context) * 0.25,
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
      child: Padding(
        padding: EdgeInsets.all(ScreenUtils().screenWidth(context) * 0.045),
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width:widget.pieChartWidth ??ScreenUtils().screenWidth(context) * 0.5,
              height:widget.pieChartHeight?? ScreenUtils().screenHeight(context) * 0.22,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 0.6,
                  centerSpaceRadius: ScreenUtils().screenWidth(context) * 0,
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
                _buildLegend("Paid amount", (widget.paidAmount/widget.totalAmountBeforeDiscount)*100, Colors.green),
                SizedBox(height: ScreenUtils().screenWidth(context) * 0.02),
                _buildLegend("Due amount", (widget.dueAmount/widget.totalAmountBeforeDiscount)*100, Colors.red),
                SizedBox(height: ScreenUtils().screenWidth(context) * 0.02),
                _buildLegend("Scholarship amount", (widget.scholarshipAmount/widget.totalAmountBeforeDiscount)*100,AppColors.progressBarColor.withOpacity(0.6)),
                SizedBox(height: ScreenUtils().screenWidth(context) * 0.02),
                _buildLegend("Concession amount", (widget.concessionAmount/widget.totalAmountBeforeDiscount)*100,AppColors.alphabetSafeArea ),
                SizedBox(height: ScreenUtils().screenWidth(context) * 0.02),

                Text(
                  "NB: This % is based on the total amount before discount",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.colorTomato
                  ),
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _getPieSections() {
    return [
      PieChartSectionData(
        color: Colors.green,
        value: widget.paidAmount,
        //title: "${presentPercentage.toStringAsFixed(0)}%",
        radius: ScreenUtils().screenWidth(context) * 0.2,
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
        radius: ScreenUtils().screenWidth(context) * 0.2,
        titleStyle: TextStyle(
            fontSize: ScreenUtils().screenWidth(context) * 0.03,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontFamily: "Poppins"
        ),
        showTitle: false,
      ),PieChartSectionData(
        color: AppColors.progressBarColor.withOpacity(0.6),
        value: widget.scholarshipAmount,
        // title: "${absentPercentage.toStringAsFixed(0)}%",
        radius: ScreenUtils().screenWidth(context) * 0.2,
        titleStyle: TextStyle(
            fontSize: ScreenUtils().screenWidth(context) * 0.03,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontFamily: "Poppins"
        ),
        showTitle: false,
      ),PieChartSectionData(
        color: AppColors.alphabetSafeArea,
        value: widget.concessionAmount,
        // title: "${absentPercentage.toStringAsFixed(0)}%",
        radius: ScreenUtils().screenWidth(context) * 0.2,
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
        ),SizedBox(width: ScreenUtils().screenWidth(context) * 0.03),
        Text(
          "${percentage.toStringAsFixed(2)} %",
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