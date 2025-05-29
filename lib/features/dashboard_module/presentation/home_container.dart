import 'package:college_super_admin_app/core/utils/constants/app_colors.dart';
import 'package:college_super_admin_app/core/utils/helper/screen_utils.dart';
import 'package:college_super_admin_app/features/dashboard_module/widgets/dashboard_small_container.dart';
import 'package:college_super_admin_app/features/dashboard_module/widgets/dashboard_small_progress_section_container.dart';
import 'package:college_super_admin_app/features/dashboard_module/widgets/new_admission_container.dart';
import 'package:flutter/material.dart';

class HomeContainer extends StatefulWidget {
  const HomeContainer({super.key});

  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DashboardSmallContainer(icon: Icons.supervisor_account_sharp, value: '9,825', text1: 'total Students', changeValue: '+0.5',),
              DashboardSmallContainer(icon: Icons.school, value: '653', text1: 'total Teachers', changeValue: '+0.5',),
            ],
          ),
          SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DashboardSmallProgressSectionContainer(
                value: 0.7,
                progressBarColor: AppColors.blue, content: 'Foods', contentValue: '175',),
              DashboardSmallProgressSectionContainer(
                value: 0.4,
                progressBarColor: AppColors.colorTomato,
                content: 'Events', contentValue: '887',),
            ],
          ),
          SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),
          NewAdmissionContainer(),
          SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: ScreenUtils().screenHeight(context)*0.14,
                width:  ScreenUtils().screenWidth(context)*0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.dailyStreakColor,

                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Auto Generated admission report",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white
                        ), ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.arrow_forward, color: AppColors.white,size: 30,))
                    ],
                  ),
                ),
              ),

              Container(
                height: ScreenUtils().screenHeight(context)*0.14,
                width:  ScreenUtils().screenWidth(context)*0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.blue,

                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Upcoming Event : ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white
                        ), ),

                      Divider(),

                      Expanded(
                        child: ListView.builder(
                            itemCount: 3,
                            itemBuilder: (BuildContext context, int index){
                              return Padding(
                                padding:  EdgeInsets.only(top:4.0),
                                child: Text("• 27th jun General meeting",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.white
                                  ), ),
                              );
                            }),
                      )

                    ],
                  ),
                ),
              ),

            ],
          )
        ],
      ),
    );
  }
}
