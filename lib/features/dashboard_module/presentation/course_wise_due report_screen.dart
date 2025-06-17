import 'dart:io';

import 'package:college_super_admin_app/core/network/apiHelper/locator.dart';
import 'package:college_super_admin_app/core/network/apiHelper/resource.dart';
import 'package:college_super_admin_app/core/network/apiHelper/status.dart';
import 'package:college_super_admin_app/core/services/localStorage/shared_pref.dart';
import 'package:college_super_admin_app/core/utils/commonWidgets/custom_dropdown.dart';
import 'package:college_super_admin_app/core/utils/commonWidgets/custom_shimmer.dart';
import 'package:college_super_admin_app/core/utils/commonWidgets/pie_chart.dart';
import 'package:college_super_admin_app/core/utils/constants/app_colors.dart';
import 'package:college_super_admin_app/core/utils/helper/common_utils.dart';
import 'package:college_super_admin_app/core/utils/helper/screen_utils.dart';
import 'package:college_super_admin_app/features/dashboard_module/data/dashboard_usecase.dart';
import 'package:college_super_admin_app/features/dashboard_module/due_report_dashboard_widget/due_report_dashboard_container.dart';
import 'package:college_super_admin_app/features/dashboard_module/due_report_dashboard_widget/expansion_widget.dart';
import 'package:college_super_admin_app/features/dashboard_module/due_report_dashboard_widget/header_section.dart';
import 'package:college_super_admin_app/features/dashboard_module/due_report_dashboard_widget/paid_due_amount_container.dart';
import 'package:college_super_admin_app/features/dashboard_module/models/all_course_details_model.dart';
import 'package:college_super_admin_app/features/dashboard_module/models/semester_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class CourseWiseDueReportScreen extends StatefulWidget {
  final int sessionId;
  const CourseWiseDueReportScreen({super.key, required this.sessionId});

  @override
  State<CourseWiseDueReportScreen> createState() => _CourseWiseDueReportScreenState();
}

class _CourseWiseDueReportScreenState extends State<CourseWiseDueReportScreen> {

  bool isLoading = false;
  final DashboardUsecase _dashboardUsecase = getIt<DashboardUsecase>();
  final SharedPref _pref = getIt<SharedPref>();
  List<AllCourseDetailsModel>courseDetailsDataList = [];
  Map<String, int> mainCourseMap = {};
  String selectedCourse ='';
  int selectedCourseId = 0;
  List<SemesterDetailsByCourseModel> listOfSemester = [];
  final ScreenshotController _screenshotController = ScreenshotController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllCourseDetails();
    //getAllSemesterDetailsByCourse();

  }

  @override
  Widget build(BuildContext context) {
    final result = calculateAmountsByCourseId(courseDetailsDataList, selectedCourseId);
    return Screenshot(
      controller: _screenshotController,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding:  EdgeInsets.only(
                top: ScreenUtils().screenWidth(context)*0.04,
                left: ScreenUtils().screenWidth(context)*0.04,
                right: ScreenUtils().screenWidth(context)*0.04,

            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HeaderSection(headerName: "Course wise semester due report",),
                    Bounceable(
                      onTap: () async{
                        final image = await _screenshotController.capture();
                        if (image != null) {
                          final directory = await getTemporaryDirectory();
                          final imagePath = await File('${directory.path}/screenshot.png').create();
                          await imagePath.writeAsBytes(image);
                          Share.shareXFiles([XFile(imagePath.path)], text: '.');
                        }
                      },
                      child: CircleAvatar(
                        backgroundColor: AppColors.gray2,
                        child: Icon(Icons.share, color: AppColors.gray7),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),
                isLoading?loading():  Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomDropdownForAttendance(
                          placeHolderText: selectedCourse.isEmpty
                              ? 'Select Course'
                              : selectedCourse,
                          data: mainCourseMap,
                          onValueSelected: (String label, int id) {
                            setState(() {
                              selectedCourse = label;
                              selectedCourseId = id;
                            });
                            getAllSemesterDetailsByCourse();
                          },
                          isDisabled: false,
                        ),
                        SizedBox(
                            height: ScreenUtils().screenHeight(context) * 0.02),
                        DueReportDashboardContainer(
                          fontsize: 13,
                          iconfontsize: 20,
                          valuefontsize: 13,
                          icon: Icons.monetization_on,
                          value: result['total_amount'].toString(),
                          text1: 'Total amount',
                          containerWidth: ScreenUtils().screenWidth(context),
                        ),
                        SizedBox(
                            height: ScreenUtils().screenHeight(context) * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            PaidDueAmountContainer(
                              value: divideStrings(double.parse(result['amount_paid'].toString()), double.parse(result['total_amount'].toString())),
                              progressBarColor: Colors.green,
                              content: 'Total Paid\namount',
                              contentValue: result['amount_paid'].toString(),
                            ),
                            PaidDueAmountContainer(
                              // onTap: (){
                              //   Navigator.pushNamed(context, "/CourseWiseDueReportScreen", arguments:currentSessionId );
                              // },
                              value: divideStrings(double.parse(result['due_amount'].toString()), double.parse(result['total_amount'].toString())),
                              progressBarColor: AppColors.colorTomato,
                              content: 'Total Due\namount',
                              color: AppColors.alphabetSafeArea3,
                              contentValue: result['due_amount'].toString(),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: ScreenUtils().screenHeight(context) * 0.01),
                        CustomPieChart(
                          paidAmount: double.parse(result['amount_paid'].toString()),
                          dueAmount: double.parse(result['due_amount'].toString()),),
                        SizedBox(
                            height: ScreenUtils().screenHeight(context) * 0.02),
                        Container(
                          width: ScreenUtils().screenWidth(context),
                          decoration: BoxDecoration(
                            color: AppColors.navbarItemColor,
                            borderRadius: BorderRadius.circular(8)
                          ),
                          child: Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            child: Text("Semester wise due report ", style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                              fontFamily: "Poppins",
                            ),),
                          ),
                        ),
                        SizedBox(
                            height: ScreenUtils().screenHeight(context) * 0.02),

                        ListView.builder(
                            physics:  NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:listOfSemester.length ,
                            itemBuilder: (BuildContext context, int index){
                          return  Padding(
                            padding:  EdgeInsets.only(
                                bottom: ScreenUtils().screenWidth(context)*0.02),
                            child: ExpansionWidget(semesterDetailsData: listOfSemester[index],),
                          );
                        }),
                        SizedBox(
                            height: ScreenUtils().screenHeight(context) * 0.02),
                      ],
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }

  getAllCourseDetails() async {
    setState(() {
      isLoading = true;
    });

    Map<String, dynamic> requestData = {
      "session_id" : widget.sessionId,
      "data_type": "course"
    };

    Resource resource =
    await _dashboardUsecase.getAllCourseDetailsData(requestData: requestData);

    if (resource.status == STATUS.SUCCESS) {

      courseDetailsDataList = (resource.data as List)
          .map((x) => AllCourseDetailsModel.fromJson(x))
          .toList();

      // get all course list with id
      for (var item in courseDetailsDataList) {
        if (!mainCourseMap.containsKey(item.courseId)) {
          mainCourseMap[item.courseName??""] = item.courseId??0;
        }
      }
      selectedCourse = mainCourseMap.keys.toList().first.toString();
      selectedCourseId = mainCourseMap.values.toList().first.toInt();
      await getAllSemesterDetailsByCourse();
      print(selectedCourseId.toString());

      //


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


  Map<String, num> calculateAmountsByCourseId(List<AllCourseDetailsModel> list, int courseId) {
    num totalAmount = 0;
    num amountPaid = 0;
    num dueAmount = 0;
    num scholarshipAmount = 0;
    num concessionAmount = 0;

    for (var item in list) {
      if (item.courseId ==courseId ) {
        totalAmount += item.totalAmount ?? 0;
        amountPaid += item.amountPaid ?? 0;
        dueAmount += item.dueAmount ?? 0;
        scholarshipAmount += item.scholarshipAmount ?? 0;
        concessionAmount += item.concessionAmount ?? 0;
      }
    }

    return {
      'total_amount': totalAmount-concessionAmount-scholarshipAmount,
      'amount_paid': amountPaid,
      'due_amount': dueAmount,
    };
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

  getAllSemesterDetailsByCourse() async {
    setState(() {
      isLoading = true;
    });

    Map<String, dynamic> requestData = {
      "session_id" : widget.sessionId,
      "data_type": "course",
      "course_id": selectedCourseId
    };

    Resource resource =
    await _dashboardUsecase.getAllCourseDetailsData(requestData: requestData);

    if (resource.status == STATUS.SUCCESS) {

      listOfSemester = (resource.data as List)
          .map((x) => SemesterDetailsByCourseModel.fromJson(x))
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


  Widget loading (){
    return Column(
      children: [
        CustomShimmer(
          height: ScreenUtils().screenHeight(context) * 0.07,
          width: ScreenUtils().screenWidth(context) ,
          radius: 10,
        ),
        SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),
        CustomShimmer(
          height: ScreenUtils().screenHeight(context) * 0.05,
          width: ScreenUtils().screenWidth(context) ,
          radius: 10,
        ),
        SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomShimmer(
              height: ScreenUtils().screenHeight(context) * 0.08,
              width: ScreenUtils().screenWidth(context)*0.4 ,
              radius: 10,
            ),
            CustomShimmer(
              height: ScreenUtils().screenHeight(context) * 0.08,
              width: ScreenUtils().screenWidth(context)*0.4 ,
              radius: 10,
            ),
          ],
        ),
        SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),
        CustomShimmer(
          height: ScreenUtils().screenHeight(context) * 0.2,
          width: ScreenUtils().screenWidth(context) ,
          radius: 10,
        ),
        SizedBox(height: ScreenUtils().screenHeight(context)*0.015,),
        CustomShimmer(
          height: ScreenUtils().screenHeight(context) * 0.05,
          width: ScreenUtils().screenWidth(context) ,
          radius: 10,
        ),
        SizedBox(height: ScreenUtils().screenHeight(context)*0.015,),
        CustomShimmer(
          height: ScreenUtils().screenHeight(context) * 0.06,
          width: ScreenUtils().screenWidth(context) ,
          radius: 10,
        ),
        SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),
        CustomShimmer(
          height: ScreenUtils().screenHeight(context) * 0.06,
          width: ScreenUtils().screenWidth(context) ,
          radius: 10,
        ),
        SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),
        CustomShimmer(
          height: ScreenUtils().screenHeight(context) * 0.06,
          width: ScreenUtils().screenWidth(context) ,
          radius: 10,
        ),
        SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),
        CustomShimmer(
          height: ScreenUtils().screenHeight(context) * 0.06,
          width: ScreenUtils().screenWidth(context) ,
          radius: 10,
        ),
        SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),
        CustomShimmer(
          height: ScreenUtils().screenHeight(context) * 0.06,
          width: ScreenUtils().screenWidth(context) ,
          radius: 10,
        ),
        SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),

      ],
    );
  }


}
