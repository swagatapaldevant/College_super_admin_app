
import 'package:college_super_admin_app/core/utils/constants/app_colors.dart';
import 'package:college_super_admin_app/core/utils/helper/screen_utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AnimatedBarChart extends StatefulWidget {
  final Map<String, int> admissionData;

  const AnimatedBarChart({Key? key, required this.admissionData}) : super(key: key);

  @override
  State<AnimatedBarChart> createState() => _AnimatedBarChartState();
}

class _AnimatedBarChartState extends State<AnimatedBarChart> with SingleTickerProviderStateMixin {
  double animationValue = 0.0;

  @override
  void initState() {
    super.initState();

    // Trigger animation after build
    Future.delayed(Duration.zero, () {
      setState(() {
        animationValue = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: animationValue),
      duration: const Duration(milliseconds: 1000),
      builder: (context, value, child) {
        return Padding(
          padding: EdgeInsets.only(
            left: ScreenUtils().screenWidth(context) * 0.04,
            right: ScreenUtils().screenWidth(context) * 0.04,
            bottom: ScreenUtils().screenWidth(context) * 0.04,
          ),
          child: Container(
            height: ScreenUtils().screenHeight(context) * 0.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.colorSkyBlue300,
              border: Border.all(color: AppColors.colorBlack, width: 2),
              boxShadow: [
                BoxShadow(
                  color: AppColors.colorBlack.withOpacity(0.25),
                  blurRadius: 4,
                  offset: const Offset(0, 4),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(ScreenUtils().screenWidth(context) * 0.04),
              child: BarChart(
                BarChartData(
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      tooltipPadding: const EdgeInsets.all(8),
                      tooltipRoundedRadius: 10,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        return BarTooltipItem(
                          '${widget.admissionData.keys.elementAt(group.x)}\n${rod.toY.toInt()}',
                          const TextStyle(color: Colors.white, fontSize: 12),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (double v, TitleMeta meta) {
                          int index = v.toInt();
                          if (index >= 0 && index < widget.admissionData.length) {
                            return SideTitleWidget(
                              meta: meta,
                              child: Text(
                                widget.admissionData.keys.elementAt(index),
                                style: const TextStyle(fontSize: 10),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          return SideTitleWidget(
                            meta: meta,
                            child: Text(
                              value.toInt().toString(),
                              style: const TextStyle(fontSize: 10),
                            ),
                          );
                        },
                      ),
                    ),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawHorizontalLine: true,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: Colors.grey.shade300,
                      strokeWidth: 1,
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  barGroups: List.generate(widget.admissionData.length, (index) {
                    final rawY = widget.admissionData.values.elementAt(index).toDouble();
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: rawY * value, // Animate from 0 to real value
                          width: 20,
                          borderRadius: BorderRadius.circular(8),
                          gradient: const LinearGradient(
                            colors: [Colors.lightBlueAccent, Colors.blueAccent],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                          backDrawRodData: BackgroundBarChartRodData(
                            show: true,
                            toY: widget.admissionData.values
                                .reduce((a, b) => a > b ? a : b)
                                .toDouble() +
                                10,
                            color: Colors.blueGrey.withOpacity(0.1),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
