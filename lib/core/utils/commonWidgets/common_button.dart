import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import '../constants/app_colors.dart';
import '../helper/screen_utils.dart';

class CommonButton extends StatelessWidget {
  final double height;
  final double width;
  final Color? buttonColor;
  final String buttonName;
  final Color buttonTextColor;
  final Color gradientColor1;
  final Color gradientColor2;
  final Function()? onTap;
  final double? fontSize;
  final double? borderRadius;
  final IconData? icon;
  final FontWeight? fontWeight;

  const CommonButton({
    super.key,
    required this.height,
    required this.width,
     this.buttonColor,
    required this.buttonName,
    required this.buttonTextColor,
    required this.gradientColor1,
    required this.gradientColor2,
    this.fontWeight,
    this.onTap,
    this.fontSize = 22,
    this.borderRadius,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: const Alignment(0.8, 1),
            colors: <Color>[
              gradientColor1,
              gradientColor2,
            ],
            tileMode: TileMode.mirror,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.colorBlack.withOpacity(0.25),
              blurRadius: 4,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
          borderRadius: BorderRadius.circular(
            borderRadius ?? ScreenUtils().screenHeight(context) * 0.025,
          ),
        ),
        child: icon != null
            ? Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              buttonName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: fontWeight??FontWeight.w700,
                color: buttonTextColor,
                fontSize: fontSize,
                fontFamily: "comic_neue",
              ),
            ),
            Icon(icon, size: 24, color: Colors.white),
          ],
        )
            : Center(
          child: Text(
            buttonName,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight:fontWeight??FontWeight.w700,
              color: buttonTextColor,
              fontSize: fontSize,
              fontFamily: "comic_neue",
            ),
          ),
        ),
      ),
    );
  }
}
