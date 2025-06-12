import 'package:college_super_admin_app/core/utils/constants/app_colors.dart';
import 'package:college_super_admin_app/core/utils/helper/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BarChartDetails extends StatefulWidget {
  final List<String> dates;
  final List<double> cash;
  final List<double> others;
  const BarChartDetails({super.key, required this.dates, required this.cash, required this.others});

  @override
  _BarChartDetailsState createState() => _BarChartDetailsState();
}

class _BarChartDetailsState extends State<BarChartDetails> {
  // final List<String> weekDays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  //
  // final List<double> blueData = [4, 5, 3.5, 6, 5, 10, 9];
  // final List<double> redData = [2, 4, 6, 4, 4.5, 6.5, 5];

  // List<double> currentBlue = List.filled(7, 0);
  // List<double> currentRed = List.filled(7, 0);
  late List<double> currentBlue;
  late List<double> currentRed;

  @override
  void initState() {
    super.initState();
    currentBlue = List.filled(widget.cash.length, 0);
    currentRed = List.filled(widget.others.length, 0);

    // Only animate if lists are not empty and of same length
    if (widget.cash.isNotEmpty &&
        widget.others.isNotEmpty &&
        widget.cash.length == widget.others.length &&
        widget.cash.length == widget.dates.length) {
      animateBars();
    } else {

      print("Warning: Provided lists are empty or not of equal length.");
    }
  }

  void animateBars() async {
    for (int i = 0; i < widget.dates.length; i++) {
      await Future.delayed(const Duration(milliseconds: 200));
      setState(() {
        currentBlue[i] = widget.cash[i];
        currentRed[i] = widget.others[i];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.2,
      child: BarChart(
        BarChartData(
          maxY: getMaxY(widget.cash + widget.others),
          barGroups: List.generate(7, (index) {
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: currentBlue[index],
                  width: 8,
                  borderRadius: BorderRadius.circular(6),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF42A5F5), Color(0xFF1E88E5)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                BarChartRodData(
                  toY: currentRed[index],
                  width: 8,
                  borderRadius: BorderRadius.circular(6),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFEF5350), Color(0xFFE53935)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ],
              barsSpace: 8,
            );
          }),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                //reservedSize: 32,
                getTitlesWidget: (value, _) {
                  final int index = value.toInt();
                  if (index >= widget.dates.length) return const SizedBox();
                  return Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Transform.rotate(
                      angle: 45 * 3.1415926535 / 180,
                      child: Text(
                        widget.dates[index],
                        style:  TextStyle(
                          fontSize: 10,
                            fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          color: AppColors.gray7
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
                    fontFamily: "Poppins",
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
