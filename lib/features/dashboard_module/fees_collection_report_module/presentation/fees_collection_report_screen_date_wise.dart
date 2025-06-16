import 'package:college_super_admin_app/core/network/apiHelper/locator.dart';
import 'package:college_super_admin_app/core/network/apiHelper/resource.dart';
import 'package:college_super_admin_app/core/network/apiHelper/status.dart';
import 'package:college_super_admin_app/core/services/localStorage/shared_pref.dart';
import 'package:college_super_admin_app/core/utils/commonWidgets/common_button.dart';
import 'package:college_super_admin_app/core/utils/commonWidgets/custom_date_picker.dart';
import 'package:college_super_admin_app/core/utils/constants/app_colors.dart';
import 'package:college_super_admin_app/core/utils/helper/common_utils.dart';
import 'package:college_super_admin_app/core/utils/helper/screen_utils.dart';
import 'package:college_super_admin_app/features/dashboard_module/data/dashboard_usecase.dart';
import 'package:college_super_admin_app/features/dashboard_module/fees_collection_report_module/widgets/date_wise_collection_container.dart';
import 'package:college_super_admin_app/features/dashboard_module/models/collect_by_session_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FeesCollectionReportScreenDateWise extends StatefulWidget {
  const FeesCollectionReportScreenDateWise({super.key});

  @override
  State<FeesCollectionReportScreenDateWise> createState() => _FeesCollectionReportScreenDateWiseState();
}

class _FeesCollectionReportScreenDateWiseState extends State<FeesCollectionReportScreenDateWise> {

  String selectedFromDate = "";
  String selectedToDate = "";

  final DashboardUsecase _dashboardUsecase = getIt<DashboardUsecase>();
  final SharedPref _pref = getIt<SharedPref>();
  bool isLoading = false;
  List<CollectBySessionModel> dateWiseCollectionList = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:  EdgeInsets.all(ScreenUtils().screenWidth(context) * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),
                  Text(
                    "Hi, Welcome back",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins",
                        color: AppColors.gray7),
                  ),
                  Text(
                    "Fees Collection Report Dashboard",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins",
                        color: AppColors.colorBlack),
                  ),
                  SizedBox(height: ScreenUtils().screenHeight(context)*0.015,),
                  Text(
                    "Please choose the date range ",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins",
                        color: AppColors.colorBlack),
                  ),
                  SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomDatePickerField(
                        onDateChanged: (String value) {
                          selectedFromDate = value;
                          setState(() {

                          });
                          },
                        placeholderText: 'To date',
                      ),

                      CustomDatePickerField(
                        onDateChanged: (String value) {
                          selectedToDate = value;
                          setState(() {

                          });
                          },
                        placeholderText: 'From date',
                      ),

                    ],
                  ),
                  SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),
                  selectedFromDate==""||selectedToDate == ""?SizedBox.shrink():
                  CommonButton(
                    onTap: (){
                      getAllFeesCollectionReport();
                    },
                      height: ScreenUtils().screenHeight(context)*0.045,
                      width: ScreenUtils().screenWidth(context),
                      buttonName: "Submit",
                      fontSize: 14,
                      borderRadius: 10,
                      buttonTextColor: AppColors.white,
                      gradientColor1: AppColors.darkBlue,
                      gradientColor2: AppColors.darkBlue),
                ],
              ),
            ),

            SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),
            selectedFromDate==""||selectedToDate == ""?SizedBox.shrink():
            isLoading?Center(child: CircularProgressIndicator()):Expanded(
              child: dateWiseCollectionList.isEmpty?Center(
                child: Text("No data found in this range", style: TextStyle(
                  fontFamily: "Poppins",
                  color: AppColors.darkBlue,
                  fontWeight: FontWeight.w500,
                  fontSize: 14
                ),),
              ) :ListView.builder(
                  itemCount: dateWiseCollectionList.length,
                  itemBuilder: (BuildContext context, int index){
                    return DateWiseCollectionContainer(
                      onTap: (){
                        Navigator.pushNamed(context, "/FeesCollectionReportByCourse",arguments:dateWiseCollectionList[index].date.toString() );
                      },
                      date: dateWiseCollectionList[index].date.toString(),
                      weekDay: getWeekdayNameFromString(dateWiseCollectionList[index].date.toString()),
                      totalCollection: dateWiseCollectionList[index].totalSum.toString(),);
                  }),
            )



          ],
        ),
      ),
    );
  }

  getAllFeesCollectionReport() async {
    setState(() {
      isLoading = true;
    });

    Map<String, dynamic> requestData = {

        "from_date" : selectedToDate,
        "to_date" : selectedFromDate,
        "ret_type": "date_wise"

    };

    Resource resource =
    await _dashboardUsecase.getAllCollectionBySession(requestData: requestData);
    if (resource.status == STATUS.SUCCESS) {

      dateWiseCollectionList = (resource.data as List)
          .map((x) => CollectBySessionModel.fromJson(x))
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

  String getWeekdayNameFromString(String dateString) {
    try {
      DateTime date = DateTime.parse(dateString); // Parses ISO 8601 format
      return DateFormat('EEEE').format(date); // Returns full weekday name like "Monday"
    } catch (e) {
      return 'Invalid date';
    }
  }


}
