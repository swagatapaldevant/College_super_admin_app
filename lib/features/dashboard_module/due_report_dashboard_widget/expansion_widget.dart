import 'package:college_super_admin_app/core/utils/commonWidgets/pie_chart.dart';
import 'package:college_super_admin_app/core/utils/constants/app_colors.dart';
import 'package:college_super_admin_app/core/utils/helper/screen_utils.dart';
import 'package:college_super_admin_app/features/dashboard_module/due_report_dashboard_widget/due_report_dashboard_container.dart';
import 'package:college_super_admin_app/features/dashboard_module/due_report_dashboard_widget/paid_due_amount_container.dart';
import 'package:college_super_admin_app/features/dashboard_module/models/semester_details_model.dart';
import 'package:flutter/material.dart';

class ExpansionWidget extends StatefulWidget {
  final SemesterDetailsByCourseModel? semesterDetailsData;


  const ExpansionWidget({
    super.key,
    required this.semesterDetailsData,

  });

  @override
  State<ExpansionWidget> createState() => _ExpansionWidgetState();
}

class _ExpansionWidgetState extends State<ExpansionWidget> {
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
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(

          title: Text(
            widget.semesterDetailsData?.semesterName.toString()??"",
            style: TextStyle(
              fontSize: 14,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600,
              color: AppColors.darkBlue,
            ),
          ),
          children: [
            Padding(
              padding: EdgeInsets.all(ScreenUtils().screenWidth(context)*0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:  EdgeInsets.all(ScreenUtils().screenWidth(context)*0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.alphabetSafeArea,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding:  EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 5
                            ),
                            child: Text("${widget.semesterDetailsData?.semesterName.toString()} (${widget.semesterDetailsData?.courseName.toString()})", style: TextStyle(
                                fontSize: 12,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600,
                                color: AppColors.white
                            ),),
                          ),
                        ),
                        SizedBox(
                            height: ScreenUtils().screenHeight(context) * 0.01),
                        DueReportDashboardContainer(
                          fontsize: 12,
                          valuefontsize: 12,
                          iconfontsize: 15,
                          icon: Icons.monetization_on,
                          value: (double.parse(widget.semesterDetailsData?.totalAmount.toString()??"")-double.parse(widget.semesterDetailsData?.scholarshipAmount.toString()??"")-double.parse(widget.semesterDetailsData?.concessionAmount.toString()??"")).toString(),
                          text1: 'Total amount',
                          containerWidth: ScreenUtils().screenWidth(context),
                        ),
                        SizedBox(
                            height: ScreenUtils().screenHeight(context) * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            PaidDueAmountContainer(
                              textfonsize: 10,
                              valuefonsize: 10,
                              value: divideStrings(double.parse(widget.semesterDetailsData?.amountPaid.toString()??""), (double.parse(widget.semesterDetailsData?.totalAmount.toString()??"")-double.parse(widget.semesterDetailsData?.scholarshipAmount.toString()??"")-double.parse(widget.semesterDetailsData?.concessionAmount.toString()??""))),
                              progressBarColor: Colors.green,
                              content: 'Total Paid\namount',
                              screenWidth:ScreenUtils().screenWidth(context) * 0.38,
                              contentValue: widget.semesterDetailsData?.amountPaid.toString()??"",
                            ),
                            PaidDueAmountContainer(
                              onTap: (){
                                Navigator.pushNamed(context, "/StudentDetailsDueScreen", arguments: widget.semesterDetailsData);
                              },
                              textfonsize: 10,
                              valuefonsize: 10,
                              screenWidth:ScreenUtils().screenWidth(context) * 0.38,
                              value: divideStrings(double.parse(widget.semesterDetailsData?.dueAmount.toString()??""), (double.parse(widget.semesterDetailsData?.totalAmount.toString()??"")-double.parse(widget.semesterDetailsData?.scholarshipAmount.toString()??"")-double.parse(widget.semesterDetailsData?.concessionAmount.toString()??""))),
                              progressBarColor: AppColors.colorTomato,
                              content: 'Total Due\namount',
                              contentValue: widget.semesterDetailsData?.dueAmount.toString()??"",
                            ),
                          ],
                        ),
                        SizedBox(
                            height: ScreenUtils().screenHeight(context) * 0.01),
                        CustomPieChart(

                          paidAmount: double.parse(widget.semesterDetailsData?.amountPaid.toString()??""),
                          dueAmount:double.parse(widget.semesterDetailsData?.dueAmount.toString()??""),
                        )

                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  double divideStrings(double numeratorStr, double denominatorStr) {
    try {
      double numerator = numeratorStr;
      double denominator = denominatorStr;
      if (denominator == 0) {
        throw ArgumentError('Division by zero is not allowed.');
      }
      return numerator / denominator;
    } catch (e) {
      print('Error: $e');
      return 0.0; // or you can choose to rethrow the exception
    }
  }

}