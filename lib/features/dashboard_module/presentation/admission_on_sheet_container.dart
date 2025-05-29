import 'package:college_super_admin_app/core/utils/constants/app_colors.dart';
import 'package:college_super_admin_app/core/utils/helper/screen_utils.dart';
import 'package:college_super_admin_app/features/dashboard_module/widgets/admission_result_every_month_container.dart';
import 'package:flutter/material.dart';

class AdmissionOnSheetContainer extends StatefulWidget {
  const AdmissionOnSheetContainer({super.key});

  @override
  State<AdmissionOnSheetContainer> createState() =>
      _AdmissionOnSheetContainerState();
}

class _AdmissionOnSheetContainerState extends State<AdmissionOnSheetContainer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          AdmissionResultEveryMonthContainer(
            weekDays: [
              'Jan',
              'Feb',
              'Mar',
              'Apr',
              'May',
              'Jun',
              'Jul',
              'Aug',
              'Sep',
              'Oct',
              'Nov',
              'Dec',
            ],
            blueData: [4, 5, 3.5, 6, 5, 10, 9, 4, 5, 3.5, 6, 5],
            redData: [2, 4, 6, 4, 4.5, 6.5, 5, 2, 4, 6, 4, 4.5], text: 'Admission result every month',
          ),

          SizedBox(height: ScreenUtils().screenHeight(context)*0.015,),

          AdmissionResultEveryMonthContainer(
            weekDays: [
              '2014',
              '2015',
              '2016',
              '2017',
              '2018',
              '2019',
              '2020',
              '2021',
              '2022',
              '2023',
              '2024',
              '2025',
            ],
            blueData: [9, 4, 5, 3.5, 6, 5,4, 5, 3.5, 6, 5, 10, ],
            redData: [2, 4, 6, 4, 4.5, 2, 4, 6, 4, 4.5, 6.5, 5, ], text:  "Admission result every Year",
          ),

          SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),

         Text('Download full result in pdf ',
           textAlign: TextAlign.center,
           style: TextStyle(
               fontSize: 12,
               fontWeight: FontWeight.w500,
               color: AppColors.gray7
           ),),
          Text('Download ',
           textAlign: TextAlign.center,
           style: TextStyle(
               fontSize: 12,
               fontWeight: FontWeight.bold,
               color: AppColors.blue
           ),),
          SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),




        ],
      ),
    );
  }
}
