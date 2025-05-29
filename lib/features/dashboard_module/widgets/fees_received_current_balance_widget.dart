import 'package:college_super_admin_app/core/utils/commonWidgets/circular_progress_bar.dart';
import 'package:college_super_admin_app/core/utils/constants/app_colors.dart';
import 'package:college_super_admin_app/core/utils/helper/screen_utils.dart';
import 'package:flutter/material.dart';

class FeesReceivedCurrentBalanceWidget extends StatelessWidget {
  const FeesReceivedCurrentBalanceWidget({super.key});

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
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding:  EdgeInsets.all(ScreenUtils().screenWidth(context)*0.03),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Row(
            children: [
              CircularProgressBar(value: 0.8,color: AppColors.blue,),
              SizedBox(width: ScreenUtils().screenWidth(context)*0.04,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("₹ 42,56,0000.00", style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.colorBlack
                  ),),
                  SizedBox(height: ScreenUtils().screenHeight(context)*0.001,),

                  Text("Current balance", style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: AppColors.colorBlack
                  ),)
                ],
              )
            ],
          ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Average from last month", style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppColors.colorBlack
                ),),
                SizedBox(height: 5,),
                RichText(
                  text: TextSpan(
                    text: '↑ 5%',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColors.progressBarColor,
                        fontSize: 12
                    ),
                    children: const <TextSpan>[
                      TextSpan(text: ' than last month', style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: AppColors.gray7,
                          fontSize: 10
                      ),),
                    ],
                  ),
                )


              ],
            )
          ],
        ),
      ),
    );
  }
}

