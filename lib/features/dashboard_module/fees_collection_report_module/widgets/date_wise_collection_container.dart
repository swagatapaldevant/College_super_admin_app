import 'package:college_super_admin_app/core/utils/constants/app_colors.dart';
import 'package:college_super_admin_app/core/utils/helper/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class DateWiseCollectionContainer extends StatefulWidget {
  final String date;
  final String weekDay;
  final String totalCollection;
  Function()? onTap;

   DateWiseCollectionContainer({
    super.key,
    required this.date,
    this.onTap,
    required this.weekDay,
    required this.totalCollection,
  });

  @override
  State<DateWiseCollectionContainer> createState() => _DateWiseCollectionContainerState();
}

class _DateWiseCollectionContainerState extends State<DateWiseCollectionContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtils().screenWidth(context) * 0.04,
        vertical: ScreenUtils().screenWidth(context) * 0.02,
      ),
      child: Bounceable(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.optionContainer, AppColors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.gray7.withOpacity(0.2),
                blurRadius: 6,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 18, color: AppColors.rewardBg),
                    const SizedBox(width: 8),
                    Text(
                      "${widget.date} (${widget.weekDay})",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                     Icon(Icons.attach_money, size: 18, color: AppColors.rewardBg),
                    const SizedBox(width: 8),
                    Text(
                      "Collection: ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkBlue,
                        fontFamily: "Poppins",
                      ),
                    ),
                    Text(
                      widget.totalCollection,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
