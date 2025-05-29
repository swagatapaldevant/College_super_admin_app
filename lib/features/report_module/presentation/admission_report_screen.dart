import 'package:college_super_admin_app/core/utils/commonWidgets/common_button.dart';
import 'package:college_super_admin_app/core/utils/commonWidgets/common_header.dart';
import 'package:college_super_admin_app/core/utils/commonWidgets/custom_date_picker.dart';
import 'package:college_super_admin_app/core/utils/constants/app_colors.dart';
import 'package:college_super_admin_app/core/utils/helper/screen_utils.dart';
import 'package:college_super_admin_app/features/report_module/widgets/animated_bar_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AdmissionReportScreen extends StatefulWidget {
  const AdmissionReportScreen({super.key});

  @override
  State<AdmissionReportScreen> createState() => _AdmissionReportScreenState();
}

class _AdmissionReportScreenState extends State<AdmissionReportScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String selectedFromDate = "";
  String selectedToDate = "";

  final Map<String, int> admissionData = {
    'Jan': 30,
    'Feb': 50,
    'Mar': 20,
    'Apr': 60,
    'May': 400,
    'Jun': 25,
    'Jul': 55,
    'Aug': 35,
    'Sep': 45,
    'Oct': 65,
    'Nov': 15,
    'Dec': 50,
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = ScreenUtils().screenWidth(context) * 0.04;

    return Scaffold(
      backgroundColor: AppColors.colorSkyBlue300,
      body: SafeArea(
        child: Column(
          children: [
            const CommonHeader(text: 'Admission report analysis'),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                children: [
                  CustomDatePickerField(
                    onDateChanged: (String value) => selectedFromDate = value,
                    placeholderText: 'From date',
                  ),
                  const SizedBox(height: 10),
                  CustomDatePickerField(
                    onDateChanged: (String value) => selectedToDate = value,
                    placeholderText: 'To date',
                  ),
                  const SizedBox(height: 20),
                  CommonButton(
                    onTap: () {
                      // Implement search functionality
                    },
                    height: ScreenUtils().screenHeight(context) * 0.05,
                    width: ScreenUtils().screenWidth(context),
                    buttonName: "Search",
                    borderRadius: 12,
                    buttonTextColor: AppColors.white,
                    fontSize: 18,
                    gradientColor1: AppColors.rewardBg,
                    gradientColor2: AppColors.exploreCardColor,
                  ),
                  const SizedBox(height: 20),
                  TabBar(
                    controller: _tabController,
                    labelColor: AppColors.darkBlue,
                    labelStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700
                    ),
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: AppColors.darkBlue,
                    indicatorWeight: 4,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: const [
                      Tab(text: "Bar Chart"),
                      Tab(text: "Pie Chart"),
                      Tab(text: "Line Chart"),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  AnimatedBarChart(admissionData: admissionData),
                  _buildPieChart(),
                  _buildLineChart(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  // Widget _buildBarChart() {
  //   return Padding(
  //     padding: EdgeInsets.only(
  //       left: ScreenUtils().screenWidth(context) * 0.04,
  //       right: ScreenUtils().screenWidth(context) * 0.04,
  //       bottom: ScreenUtils().screenWidth(context) * 0.04,
  //     ),
  //     child: Container(
  //       height: ScreenUtils().screenHeight(context) * 0.4,
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(10),
  //         color: AppColors.colorSkyBlue300,
  //         border: Border.all(color: AppColors.colorBlack, width: 2),
  //         boxShadow: [
  //           BoxShadow(
  //             color: AppColors.colorBlack.withOpacity(0.25),
  //             blurRadius: 4,
  //             offset: const Offset(0, 4),
  //             spreadRadius: 0,
  //           ),
  //         ],
  //       ),
  //       child: Padding(
  //         padding: EdgeInsets.all(ScreenUtils().screenWidth(context) * 0.04),
  //         child: BarChart(
  //           BarChartData(
  //             barTouchData: BarTouchData(
  //               enabled: true,
  //               touchTooltipData: BarTouchTooltipData(
  //                 tooltipPadding: const EdgeInsets.all(8),
  //                 tooltipRoundedRadius: 10,
  //                 getTooltipItem: (group, groupIndex, rod, rodIndex) {
  //                   return BarTooltipItem(
  //                     '${admissionData.keys.elementAt(group.x)}\n${rod.toY.toInt()}',
  //                     const TextStyle(color: Colors.white, fontSize: 12),
  //                   );
  //                 },
  //               ),
  //             ),
  //             titlesData: FlTitlesData(
  //               bottomTitles: AxisTitles(
  //                 sideTitles: SideTitles(
  //                   showTitles: true,
  //                   reservedSize: 40,
  //                   getTitlesWidget: (double value, TitleMeta meta) {
  //                     int index = value.toInt();
  //                     if (index >= 0 && index < admissionData.length) {
  //                       return SideTitleWidget(
  //                         meta: meta,
  //                         child: Text(
  //                           admissionData.keys.elementAt(index),
  //                           style: const TextStyle(fontSize: 10),
  //                         ),
  //                       );
  //                     }
  //                     return const SizedBox.shrink();
  //                   },
  //                 ),
  //               ),
  //               leftTitles: AxisTitles(
  //                 sideTitles: SideTitles(
  //                   showTitles: true,
  //                   reservedSize: 40,
  //                   getTitlesWidget: (double value, TitleMeta meta) {
  //                     return SideTitleWidget(
  //                       meta: meta,
  //                       child: Text(
  //                         value.toInt().toString(),
  //                         style: const TextStyle(fontSize: 10),
  //                       ),
  //                     );
  //                   },
  //                 ),
  //               ),
  //               topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
  //               rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
  //             ),
  //             gridData: FlGridData(
  //               show: true,
  //               drawHorizontalLine: true,
  //               getDrawingHorizontalLine: (value) => FlLine(
  //                 color: Colors.grey.shade300,
  //                 strokeWidth: 1,
  //               ),
  //             ),
  //             borderData: FlBorderData(
  //               show: true,
  //               border: Border.all(color: Colors.black, width: 1),
  //             ),
  //             barGroups: List.generate(admissionData.length, (index) {
  //               return BarChartGroupData(
  //                 x: index,
  //                 barRods: [
  //                   BarChartRodData(
  //                     toY: admissionData.values.elementAt(index).toDouble(),
  //                     width: 20,
  //                     borderRadius: BorderRadius.circular(8),
  //                     gradient: const LinearGradient(
  //                       colors: [Colors.lightBlueAccent, Colors.blueAccent],
  //                       begin: Alignment.bottomCenter,
  //                       end: Alignment.topCenter,
  //                     ),
  //                     backDrawRodData: BackgroundBarChartRodData(
  //                       show: true,
  //                       toY: admissionData.values.reduce((a, b) => a > b ? a : b).toDouble() + 10,
  //                       color: Colors.blueGrey.withOpacity(0.1),
  //                     ),
  //                   ),
  //                 ],
  //               );
  //             }),
  //           ),
  //           duration: const Duration(milliseconds: 1000), // animate bars
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildPieChart() {
    final total = admissionData.values.reduce((a, b) => a + b);

    return Padding(
      padding:  EdgeInsets.only(
        left: ScreenUtils().screenWidth(context)*0.04,
        right: ScreenUtils().screenWidth(context)*0.04,
        bottom: ScreenUtils().screenWidth(context)*0.04,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.colorSkyBlue300,
          border: Border.all(color: AppColors.colorBlack,width: 2),
          boxShadow: [
            BoxShadow(
              color: AppColors.colorBlack.withOpacity(0.25), // Shadow color
              blurRadius: 4, // Blur radius
              offset: Offset(0, 4), // Horizontal and vertical offset
              spreadRadius: 0, // How much the shadow will spread
            ),
          ],
        ),
        child: PieChart(
          PieChartData(
            sections: admissionData.entries.map((entry) {
              final percentage = (entry.value / total) * 100;
              return PieChartSectionData(
                title: '${entry.key}\n${percentage.toStringAsFixed(1)}%',
                value: entry.value.toDouble(),
                color: _getColorForMonth(entry.key),
                radius: ScreenUtils().screenWidth(context)*0.35,
                titleStyle:  TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white
                ),
              );
            }).toList(),
            sectionsSpace: 1,
            centerSpaceRadius: 20,
          ),
        ),
      ),
    );
  }


  Widget _buildLineChart() {
    return Padding(
      padding: EdgeInsets.only(
        left: ScreenUtils().screenWidth(context) * 0.04,
        right: ScreenUtils().screenWidth(context) * 0.04,
        bottom: ScreenUtils().screenWidth(context) * 0.04,
      ),
      child: Container(
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
          padding: EdgeInsets.all(ScreenUtils().screenWidth(context) * 0.05),
          child: LineChart(
            LineChartData(
              minY: 0,
              maxY: (admissionData.values.reduce((a, b) => a > b ? a : b) + 10).toDouble(),
              lineTouchData: LineTouchData(
                enabled: true,
                touchTooltipData: LineTouchTooltipData(
                  tooltipRoundedRadius: 10,
                  getTooltipItems: (touchedSpots) {
                    return touchedSpots.map((LineBarSpot spot) {
                      return LineTooltipItem(
                        '${admissionData.keys.elementAt(spot.x.toInt())}: ${spot.y.toInt()}',
                        const TextStyle(color: Colors.white, fontSize: 12),
                      );
                    }).toList();
                  },
                ),
              ),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: true,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: Colors.grey.shade300,
                  strokeWidth: 1,
                ),
                getDrawingVerticalLine: (value) => FlLine(
                  color: Colors.grey.shade300,
                  strokeWidth: 1,
                ),
              ),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 32,
                    getTitlesWidget: (value, meta) {
                      int index = value.toInt();
                      if (index < admissionData.length) {
                        return SideTitleWidget(
                          meta: meta,
                          child: Text(
                            admissionData.keys.elementAt(index),
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
                    getTitlesWidget: (value, meta) {
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
              borderData: FlBorderData(
                show: true,
                border: Border.all(color: Colors.black, width: 1),
              ),
              lineBarsData: [
                LineChartBarData(
                  isCurved: true,
                  color: Colors.green,
                  gradient: const LinearGradient(
                    colors: [Colors.green, Colors.lightGreenAccent],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  barWidth: 4,
                  isStrokeCapRound: true,
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: [
                        Colors.green.withOpacity(0.3),
                        Colors.lightGreenAccent.withOpacity(0.1)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  dotData: FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, barData, index) {
                      return FlDotCirclePainter(
                        radius: 4,
                        color: Colors.white,
                        strokeWidth: 2,
                        strokeColor: Colors.green,
                      );
                    },
                  ),
                  spots: List.generate(admissionData.length, (index) {
                    return FlSpot(
                      index.toDouble(),
                      admissionData.values.elementAt(index).toDouble(),
                    );
                  }),
                ),
              ],
            ),
            duration: const Duration(milliseconds: 1000), // animation duration
          ),
        ),
      ),
    );
  }

  Color _getColorForMonth(String month) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.red,
      Colors.orange,
      Colors.purple,
      Colors.cyan,
      Colors.amber,
      Colors.teal,
      Colors.pink,
      Colors.indigo,
      Colors.lime,
      Colors.brown,
    ];
    return colors[admissionData.keys.toList().indexOf(month) % colors.length];
  }
}
