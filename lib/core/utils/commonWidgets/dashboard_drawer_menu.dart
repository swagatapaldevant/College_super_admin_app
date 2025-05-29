
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../helper/screen_utils.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected ;
  late Function()? onClicked;

  MenuItem(
      {required this.title ,required this.icon,this.isSelected = false,
        this.onClicked,

        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        color: isSelected ?AppColors.white : Colors.transparent,
      ),
      child: ListTile(

        onTap: () {
          if (onClicked != null) onClicked!();
        },
        leading: Icon(icon, color: isSelected?AppColors.colorBlack:AppColors.white,),
        title: Text(
          title ?? "",
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontFamily: "Poppins",
              color: isSelected?AppColors.colorBlack:AppColors.white,
              fontSize: ScreenUtils().screenWidth(context)*0.042,
            fontWeight: FontWeight.w600
          ),
        ),
      ),
    );
  }
}