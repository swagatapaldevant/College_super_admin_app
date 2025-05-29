import 'package:college_super_admin_app/core/utils/constants/app_colors.dart';
import 'package:college_super_admin_app/core/utils/helper/screen_utils.dart';
import 'package:flutter/material.dart';

class DashboardSmallContainer extends StatelessWidget {
  final IconData icon;
  final String value;
  final String text1;
  final String changeValue;
  const DashboardSmallContainer({super.key, required this.icon, required this.value, required this.text1, required this.changeValue});

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              spacing: 3,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.colorBlack,
                  fontSize: 14
                ),),
                Text(text1, style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: AppColors.colorBlack,
                    fontSize: 12
                ),),
                RichText(
                  text: TextSpan(
                    text: '$changeValue%',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColors.progressBarColor,
                        fontSize: 11
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
            ),
            Icon(
              icon,
              color: AppColors.blue,size: 25,)
          ],
        ),
      ),
    );
  }
}

