import 'package:college_super_admin_app/core/network/apiHelper/locator.dart';
import 'package:college_super_admin_app/core/network/apiHelper/resource.dart';
import 'package:college_super_admin_app/core/network/apiHelper/status.dart';
import 'package:college_super_admin_app/core/services/localStorage/shared_pref.dart';
import 'package:college_super_admin_app/core/utils/commonWidgets/circular_progress_bar.dart';
import 'package:college_super_admin_app/core/utils/commonWidgets/common_button.dart';
import 'package:college_super_admin_app/core/utils/commonWidgets/common_dialog.dart';
import 'package:college_super_admin_app/core/utils/constants/app_colors.dart';
import 'package:college_super_admin_app/core/utils/helper/app_dimensions.dart';
import 'package:college_super_admin_app/core/utils/helper/common_utils.dart';
import 'package:college_super_admin_app/core/utils/helper/screen_utils.dart';
import 'package:college_super_admin_app/features/dashboard_module/data/dashboard_usecase.dart';
import 'package:college_super_admin_app/features/dashboard_module/presentation/fees_received_container.dart';
import 'package:college_super_admin_app/features/dashboard_module/presentation/scholarship_trends_container.dart';
import 'package:college_super_admin_app/features/dashboard_module/widgets/dashboard_small_container.dart';
import 'package:college_super_admin_app/features/dashboard_module/widgets/dashboard_small_progress_section_container.dart';
import 'package:college_super_admin_app/features/dashboard_module/widgets/header_section.dart';
import 'package:college_super_admin_app/features/dashboard_module/widgets/new_admission_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'admission_on_sheet_container.dart';
import 'course_revenue_container.dart';
import 'home_container.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DateTime? currentBackPressTime;
  int _selectedIndex = 0;
  String imgUrl = "";
  String userNme = "";

  bool isLoading = false;
  final DashboardUsecase _dashboardUsecase = getIt<DashboardUsecase>();
  final SharedPref _pref = getIt<SharedPref>();
  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    getLocalData();


  }

  Future<void> getLocalData() async {
    try {
      final image = await _pref.getProfileImage();
      final userName = await _pref.getUserName();
      if (image != null) {
        setState(() {
          imgUrl = "https://plus.unsplash.com/premium_photo-1689568126014-06fea9d5d341?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D";
          userNme= userName??"";
        });
      }
    } catch (e) {
      print('Error loading local data: $e');
    }
  }

  void _toggleContainer(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        DateTime now = DateTime.now();
        if (didPop ||
            currentBackPressTime == null ||
            now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
          currentBackPressTime = now;
          Fluttertoast.showToast(msg: 'Tap back again to Exit');
          // return false;
        } else {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
          body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left:ScreenUtils().screenWidth(context) * 0.04,
                right:ScreenUtils().screenWidth(context) * 0.04,
                top:ScreenUtils().screenWidth(context) * 0.02
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleAvatar(
                        backgroundColor: AppColors.gray2,
                        child: Icon(
                          Icons.notifications_active,
                          color: AppColors.gray7,
                        )),
                    SizedBox(
                      width: 8,
                    ),
                    HeaderSection(imgUrl: imgUrl, name: userNme,),
                    SizedBox(
                      width: 8,
                    ),
                    Bounceable(
                      onTap: (){
                        CommonDialog(
                            icon: Icons.logout,
                            title: "Log Out",
                            msg:
                            "You are about to logout of your account. Please confirm.",
                            activeButtonLabel: "Log Out",
                            context: context,
                            activeButtonOnClicked: () {
                              _pref.clearOnLogout();
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                "/SigninScreen",
                                    (Route<dynamic> route) =>
                                false, // Removes all previous routes
                              );
                            });
                      },
                      child: CircleAvatar(
                          backgroundColor: AppColors.gray2,
                          child: Icon(
                            Icons.logout,
                            color: AppColors.darkBlue,
                          )),
                    ),
                  ],
                ),
                Text(
                  "Dashboard",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.colorBlack),
                ),
                Text(
                  "Hi, Welcome back",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.gray7),
                ),
                SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonButton(
                        onTap: () {
                          _toggleContainer(0);
                        },
                        borderRadius: 8,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        height: ScreenUtils().screenHeight(context) * 0.062,
                        width: ScreenUtils().screenWidth(context) * 0.17,
                        //borderColor: _selectedIndex == 0 ? AppColors.profileTextColor:AppColors.profileTextColor,
                        buttonName: "Home",
                        buttonTextColor: _selectedIndex == 0?AppColors.white:AppColors.gray7,
                        gradientColor1: _selectedIndex == 0
                            ? AppColors.blue
                            : AppColors.gray2,
                        gradientColor2: _selectedIndex == 0
                            ? AppColors.blue
                            : AppColors.gray2),
                    CommonButton(
                        onTap: () {
                          _toggleContainer(1);
                        },
                        borderRadius: 8,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        height: ScreenUtils().screenHeight(context) * 0.06,
                        width: ScreenUtils().screenWidth(context) * 0.17,
                        //borderColor: _selectedIndex == 1 ? AppColors.profileTextColor:AppColors.profileTextColor,
                        buttonName: "Fees Received",
                        gradientColor1: _selectedIndex == 1
                            ? AppColors.blue
                            : AppColors.gray2,
                        gradientColor2: _selectedIndex == 1
                            ? AppColors.blue
                            : AppColors.gray2,
                        buttonTextColor:_selectedIndex == 1?AppColors.white:AppColors.gray7),
                    CommonButton(
                        onTap: () {
                          _toggleContainer(2);
                        },
                        borderRadius: 8,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        height: ScreenUtils().screenHeight(context) * 0.06,
                        width: ScreenUtils().screenWidth(context) * 0.17,
                        //borderColor: _selectedIndex == 2 ? AppColors.profileTextColor:AppColors.profileTextColor,
                        buttonName: "Admission Sheet",
                        gradientColor1: _selectedIndex == 2
                            ? AppColors.blue
                            : AppColors.gray2,
                        gradientColor2: _selectedIndex == 2
                            ? AppColors.blue
                            : AppColors.gray2,
                        buttonTextColor: _selectedIndex == 2?AppColors.white:AppColors.gray7),
                    CommonButton(
                        onTap: () {
                          _toggleContainer(3);
                        },
                        borderRadius: 8,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        height: ScreenUtils().screenHeight(context) * 0.06,
                        width: ScreenUtils().screenWidth(context) * 0.17,
                        //borderColor: _selectedIndex == 2 ? AppColors.profileTextColor:AppColors.profileTextColor,
                        buttonName: "Course Revenue",
                        gradientColor1: _selectedIndex == 3
                            ? AppColors.blue
                            : AppColors.gray2,
                        gradientColor2: _selectedIndex == 3
                            ? AppColors.blue
                            : AppColors.gray2,
                        buttonTextColor: _selectedIndex == 3?AppColors.white:AppColors.gray7),
                    CommonButton(
                        onTap: () {
                          _toggleContainer(4);
                        },
                        borderRadius: 8,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        height: ScreenUtils().screenHeight(context) * 0.06,
                        width: ScreenUtils().screenWidth(context) * 0.17,
                        //borderColor: _selectedIndex == 2 ? AppColors.profileTextColor:AppColors.profileTextColor,
                        buttonName: "Scholarship Trends",
                        gradientColor1: _selectedIndex == 4
                            ? AppColors.blue
                            : AppColors.gray2,
                        gradientColor2: _selectedIndex == 4
                            ? AppColors.blue
                            : AppColors.gray2,
                        buttonTextColor: _selectedIndex == 4?AppColors.white:AppColors.gray7),
                  ],
                ),
                SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: _buildScrollableContainer(_selectedIndex),
                ),
          
              ],
            ),
          ),
        ),
      )),
    );
  }

  Widget _buildScrollableContainer(int index) {
    switch (index) {
      case 0:
        return HomeContainer();
      case 1:
        return FeesReceivedContainer();
      case 2:
        return AdmissionOnSheetContainer();
      case 3:
        return CourseRevenueContainer();
      case 4:
        return ScholarshipTrendsContainer();
      default:
        return SizedBox.shrink();
    }
  }



}




