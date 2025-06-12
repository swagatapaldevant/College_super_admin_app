import 'package:college_super_admin_app/core/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class HeaderSection extends StatelessWidget {
  final String headerName;
  const HeaderSection({super.key, required this.headerName});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Bounceable(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, size: 30,color: AppColors.colorBlack,)),
        SizedBox(width: 10,),
        Text(headerName, style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
            fontFamily: "Poppins",
          color: AppColors.colorBlack
        ),)
      ],
    );
  }
}
