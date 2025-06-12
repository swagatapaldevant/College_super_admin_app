import 'dart:io';

import 'package:college_super_admin_app/core/network/apiHelper/locator.dart';
import 'package:college_super_admin_app/core/network/apiHelper/resource.dart';
import 'package:college_super_admin_app/core/network/apiHelper/status.dart';
import 'package:college_super_admin_app/core/services/localStorage/shared_pref.dart';
import 'package:college_super_admin_app/core/utils/commonWidgets/custom_shimmer.dart';
import 'package:college_super_admin_app/core/utils/constants/app_colors.dart';
import 'package:college_super_admin_app/core/utils/helper/common_utils.dart';
import 'package:college_super_admin_app/core/utils/helper/screen_utils.dart';
import 'package:college_super_admin_app/features/dashboard_module/data/dashboard_usecase.dart';
import 'package:college_super_admin_app/features/dashboard_module/due_report_dashboard_widget/header_section.dart';
import 'package:college_super_admin_app/features/dashboard_module/models/semester_details_model.dart';
import 'package:college_super_admin_app/features/dashboard_module/models/studentDueDetailsModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class StudentDetailsDueScreen extends StatefulWidget {
  final SemesterDetailsByCourseModel semesterDetailsData;

  const StudentDetailsDueScreen({super.key, required this.semesterDetailsData});

  @override
  State<StudentDetailsDueScreen> createState() => _StudentDetailsDueScreenState();
}

class _StudentDetailsDueScreenState extends State<StudentDetailsDueScreen> {

  bool isLoading = false;
  final DashboardUsecase _dashboardUsecase = getIt<DashboardUsecase>();
  final SharedPref _pref = getIt<SharedPref>();
  List<StudentDetailsByCourseDueModel> studentList = [];
  final ScreenshotController _screenshotController = ScreenshotController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllStudentDueByCourse();
  }

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: _screenshotController,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtils().screenWidth(context) * 0.04,
              vertical: ScreenUtils().screenWidth(context) * 0.04,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HeaderSection(headerName: "Course wise Students Due Report"),
                    Bounceable(
                      onTap: () async{
                        final image = await _screenshotController.capture();
                        if (image != null) {
                          final directory = await getTemporaryDirectory();
                          final imagePath = await File('${directory.path}/screenshot.png').create();
                          await imagePath.writeAsBytes(image);
                          Share.shareXFiles([XFile(imagePath.path)], text: '');
                        }
                      },
                      child: CircleAvatar(
                        backgroundColor: AppColors.gray2,
                        child: Icon(Icons.share, color: AppColors.gray7),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                _buildTableHeader(),
                // Show loader while loading
                if (isLoading)
                  loader()
                else
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        SizedBox(height: 10),

                        Expanded(
                          child: ListView.builder(
                            itemCount: studentList.length,
                            itemBuilder: (context, index) {
                              final student = studentList[index];
                              final total = (double.parse(student.totalAmount.toString())
                                  - double.parse(student.scholarshipAmount.toString())
                                  - double.parse(student.concessionAmount.toString()))
                                  .toStringAsFixed(2);
                              final paid = double.parse(student.amountPaid.toString()).toStringAsFixed(2);
                              final due = double.parse(student.dueAmount.toString()).toStringAsFixed(2);

                              return _buildTableRow(
                                studentName: student.fullName.toString(),
                                totalAmount: total,
                                paidAmount: paid,
                                dueAmount: due,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );

  }

  Widget _buildTableHeader() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkBlue,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildTableCell("Student", flex: 2, isHeader: true),
          _buildTableCell("Total", isHeader: true),
          _buildTableCell("Paid", isHeader: true),
          _buildTableCell("Due", isHeader: true),
        ],
      ),
    );
  }

  Widget _buildTableRow({
    required String studentName,
    required String totalAmount,
    required String paidAmount,
    required String dueAmount,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          _buildTableCell(studentName, flex: 2),
          _buildTableCell("\$$totalAmount"),
          _buildTableCell("\$$paidAmount", color: AppColors.progressBarColor),
          _buildTableCell("\$$dueAmount", color: AppColors.colorTomato),
        ],
      ),
    );
  }

  Widget _buildTableCell(
      String text, {
        int flex = 1,
        bool isHeader = false,
        Color? color,
      }) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 6),
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              color: isHeader ? Colors.transparent : Colors.grey.shade300,
              width: 1,
            ),
          ),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isHeader ? 13 : 12,
              fontFamily: "Poppins",
              fontWeight: isHeader ? FontWeight.bold : FontWeight.w500,
              color: color ?? (isHeader ? Colors.white : AppColors.colorBlack),
            ),
          ),
        ),
      ),
    );
  }

  getAllStudentDueByCourse() async {
    setState(() {
      isLoading = true;
    });

    Map<String, dynamic> requestData = {
      "session_id" : widget.semesterDetailsData.sessionId,
      "data_type": "course",
      "course_id": widget.semesterDetailsData.courseId,
      "semester_id": widget.semesterDetailsData.semesterId
    };

    Resource resource =
    await _dashboardUsecase.getAllCourseDetailsData(requestData: requestData);

    if (resource.status == STATUS.SUCCESS) {

      studentList = (resource.data as List)
          .map((x) => StudentDetailsByCourseDueModel.fromJson(x))
          .toList();
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      CommonUtils().flutterSnackBar(
          context: context, mes: resource.message ?? "", messageType: 4);
    }
  }


  Widget loader(){
    return Expanded(
      child: ListView.builder(
          itemCount: 15,
          itemBuilder: (BuildContext context, int index){
            return  Padding(
              padding:  EdgeInsets.only(
                  top: ScreenUtils().screenHeight(context)*0.012),
              child: CustomShimmer(
                height: ScreenUtils().screenHeight(context) * 0.07,
                width: ScreenUtils().screenWidth(context) ,
                radius: 10,
              ),
            );
          }),
    );
  }

}
