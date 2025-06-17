import 'package:college_super_admin_app/core/utils/commonWidgets/circular_progress_bar.dart';
import 'package:college_super_admin_app/core/utils/constants/app_colors.dart';
import 'package:college_super_admin_app/core/utils/helper/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class PaidDueAmountContainer extends StatelessWidget {
  final Color progressBarColor;
  final String content;
  final String contentValue;
  final double value;
  final double? screenWidth;
  Function()? onTap;
  final double? textfonsize;
  final double? valuefonsize;
  final Color? color;
   PaidDueAmountContainer(
      {super.key,
      required this.progressBarColor,
        this.screenWidth,
      required this.content,
        this.textfonsize,
        this.valuefonsize,
         this.color,
      required this.contentValue,
        this.onTap,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: Container(
        width:screenWidth?? ScreenUtils().screenWidth(context) * 0.42,
        decoration: BoxDecoration(
          color: color??AppColors.white,
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
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircularProgressBar(
                value: value,
                color: progressBarColor,
              ),
              SizedBox(
                width: ScreenUtils().screenWidth(context) * 0.04,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "₹ $contentValue",
                    style: TextStyle(
                        fontSize:valuefonsize?? 14,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                        color: AppColors.colorBlack),
                  ),
                  Text(
                    content,
                    style: TextStyle(
                        fontSize:textfonsize?? 12,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        color: AppColors.colorBlack),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
