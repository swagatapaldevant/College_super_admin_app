import 'package:college_super_admin_app/core/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class DueReportDashboardContainer extends StatelessWidget {
  final IconData icon;
  final String value;
  final String text1;
  final double containerWidth;
  final double? fontsize;
  final double? valuefontsize;
  final double? iconfontsize;
  const DueReportDashboardContainer({super.key, this.fontsize,this.valuefontsize,this.iconfontsize,required this.icon, required this.value, required this.text1, required this.containerWidth,});

  @override
  Widget build(BuildContext context) {
    return Container(
      width:containerWidth,
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
        padding:  EdgeInsets.symmetric(horizontal: 12.0, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: AppColors.progressBarColor,size:iconfontsize?? 25,),
                Text("$text1 : ",
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.colorBlack,
                    fontFamily: "Poppins",
                    fontSize: fontsize??16
                ),),
                Text(value,overflow: TextOverflow.ellipsis,
                  softWrap: true, style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.colorBlack,
                    fontFamily: "Poppins",
                    fontSize:valuefontsize?? 15
                ),),

              ],
            ),

          ],
        ),
      ),
    );
  }
}
