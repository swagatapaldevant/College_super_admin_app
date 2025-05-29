
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

import '../constants/app_colors.dart';
import '../constants/app_string.dart';
import '../helper/screen_utils.dart';

class CommonHeader extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  const CommonHeader({super.key,  this.onPressed, required this.text,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(ScreenUtils().screenWidth(context) * 0.045),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Bounceable(
                onTap:(){
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.darkBlue,
                  size: 30,
                ),
              ),
              SizedBox(
                width: ScreenUtils().screenWidth(context) * 0.05,
              ),
              Text(
                text,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkBlue,
                    fontSize: ScreenUtils().screenWidth(context)*0.042),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
