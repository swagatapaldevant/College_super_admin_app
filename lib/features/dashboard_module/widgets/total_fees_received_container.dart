import 'package:college_super_admin_app/core/utils/commonWidgets/circular_progress_bar.dart';
import 'package:college_super_admin_app/core/utils/constants/app_colors.dart';
import 'package:college_super_admin_app/core/utils/helper/screen_utils.dart';
import 'package:college_super_admin_app/features/dashboard_module/widgets/bar_chart.dart';
import 'package:flutter/material.dart';

class TotalFeesReceivedContainer extends StatefulWidget {
  const TotalFeesReceivedContainer({super.key});

  @override
  State<TotalFeesReceivedContainer> createState() =>
      _TotalFeesReceivedContainerState();
}

class _TotalFeesReceivedContainerState
    extends State<TotalFeesReceivedContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtils().screenWidth(context),
      //height: ScreenUtils().screenHeight(context) * 0.3,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.gray7.withOpacity(0.25),
            blurRadius: 4,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding:  EdgeInsets.all(ScreenUtils().screenWidth(context)*0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Total fees received", style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.colorBlack
            ),),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                graphIndicator(0.7, AppColors.blue,"Others", "UPI/ Net banking"),

                graphIndicator(0.6, AppColors.colorTomato,"Cash", "Cash/ Cheque"),

              ],
            ),
            SizedBox(height: 10,),
            BarChartDetails(),
          ],
        ),
      ),
    );
  }
  
  Widget graphIndicator( double value,Color color,String text1, String text2,){
    return Row(
      children: [
        SizedBox(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(
            value: value,
            strokeWidth: 4,
            color: color,
            backgroundColor: AppColors.gray3,
          ),
        ),
       // CircularProgressBar(value:value, color:color ,),
        SizedBox(width: 10,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 4,
          children: [
            Text(text1, style: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.colorBlack,
              fontSize: 12
            ),),

            Text(text2, style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.gray7,
                fontSize: 11
            ),)
          ],
        )
        
      ],
    );
  }
  
}
