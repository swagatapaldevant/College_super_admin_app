import 'package:college_super_admin_app/core/utils/commonWidgets/circular_progress_bar.dart';
import 'package:college_super_admin_app/core/utils/constants/app_colors.dart';
import 'package:college_super_admin_app/core/utils/helper/screen_utils.dart';
import 'package:flutter/material.dart';

class DashboardSmallProgressSectionContainer extends StatelessWidget {
  final Color progressBarColor;
  final String content;
  final String contentValue;
  final double value;
  const DashboardSmallProgressSectionContainer({super.key,
    required this.value,
    required this.progressBarColor, required this.content, required this.contentValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtils().screenWidth(context)*0.4,
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
        padding:  EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircularProgressBar(value: value, color: progressBarColor,),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(contentValue, style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.colorBlack,
                  fontFamily: "Poppins",
                ),),

                Text(content, style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.colorBlack,
                  fontFamily: "Poppins",
                ),),
              ],
            )
            
          ],
        ),
      ),
    );
  }
}
