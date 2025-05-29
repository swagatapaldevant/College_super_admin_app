import 'package:college_super_admin_app/core/utils/helper/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BarChartDetails extends StatefulWidget {
  const BarChartDetails({super.key});

  @override
  _BarChartDetailsState createState() => _BarChartDetailsState();
}

class _BarChartDetailsState extends State<BarChartDetails> {
  final List<String> weekDays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  final List<double> blueData = [4, 5, 3.5, 6, 5, 10, 9];
  final List<double> redData = [2, 4, 6, 4, 4.5, 6.5, 5];

  List<double> currentBlue = List.filled(7, 0);
  List<double> currentRed = List.filled(7, 0);

  @override
  void initState() {
    super.initState();
    animateBars();
  }

  void animateBars() async {
    for (int i = 0; i < blueData.length; i++) {
      await Future.delayed(const Duration(milliseconds: 200));
      setState(() {
        currentBlue[i] = blueData[i];
        currentRed[i] = redData[i];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: BarChart(
        BarChartData(
          maxY: 12,
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
                  return Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Text(
                      weekDays[value.toInt()],
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
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
}
