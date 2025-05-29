import 'package:college_super_admin_app/core/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';


class CommonBackButton extends StatelessWidget {
  final Color? bgColor;
  const CommonBackButton({super.key, this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () {
        Navigator.pop(context);
      },
      child: CircleAvatar(
        backgroundColor:bgColor?? AppColors.gameControllerBg.withOpacity(0.5),
        child: Center(child: Icon(Icons.arrow_back, size: 30, color: AppColors.white,)),
      ),
    );
  }
}
