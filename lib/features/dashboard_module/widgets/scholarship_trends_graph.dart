import 'package:college_super_admin_app/core/utils/constants/app_colors.dart';
import 'package:college_super_admin_app/core/utils/helper/screen_utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ScholarshipTrendsGraph extends StatefulWidget {
  const ScholarshipTrendsGraph({super.key});

  @override
  State<ScholarshipTrendsGraph> createState() => _ScholarshipTrendsGraphState();
}

class _ScholarshipTrendsGraphState extends State<ScholarshipTrendsGraph> {
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
        padding:  EdgeInsets.all(ScreenUtils().screenWidth(context)*0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Scholarship trends details", style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.colorBlack
            ),),
            AspectRatio(
              aspectRatio: 1.6,
              child: LineChart(
                _buildLineChartData(),
                duration: const Duration(milliseconds: 800), // Animation
                curve: Curves.easeInOut,
              ),
            ),
          ],
        ),
      ),
    );
  }

  LineChartData _buildLineChartData() {
    return LineChartData(
      minY: 0,
      maxY: 12,
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) => FlLine(
          color: Colors.grey.withOpacity(0.1),
          strokeWidth: 1,
        ),
      ),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, _) => Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                (2017 + value.toInt()).toString(),
                style: const TextStyle(fontSize: 10, color: Colors.black,
                fontWeight: FontWeight.w500
                ),
              ),
            ),
            interval: 1,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Colors.black12),
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          isCurved: true,
          spots: const [
            FlSpot(0, 4),
            FlSpot(1, 5),
            FlSpot(2, 3),
            FlSpot(3, 4.5),
            FlSpot(4, 7),
            FlSpot(5, 6),
            FlSpot(6, 8),
            FlSpot(7, 4.5),
          ],
          isStrokeCapRound: true,
          barWidth: 3,
          color: AppColors.blue,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, bar, index) => FlDotCirclePainter(
              radius: 3,
              color: AppColors.blue,
              strokeWidth: 2,
              strokeColor: AppColors.blue,
            ),
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                Colors.blue.withOpacity(0.3),
                Colors.blue.withOpacity(0.05),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
      lineTouchData: LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipRoundedRadius: 8,
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((touchedSpot) {
              final year = 2017 + touchedSpot.x.toInt();
              return LineTooltipItem(
                '$year\n${touchedSpot.y.toStringAsFixed(1)}',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            }).toList();
          },
        ),
      ),
    );
  }
}
