import 'package:college_super_admin_app/core/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  final String imgUrl;
  final String name;
  const HeaderSection({super.key, required this.imgUrl, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.gray2,
        borderRadius: BorderRadius.circular(30),

      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(imgUrl),
              //backgroundImage: NetworkImage("https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D"),
            ),
            SizedBox(width: 5,),
            Column(
              children: [
                Text(name, style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                    fontFamily: "Poppins",
                  color: AppColors.colorBlack
                ),),

                Text("Super admin", style: TextStyle(
                    fontSize: 10,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400,
                    color: AppColors.gray7
                ),)
              ],
            )
          ],
        ),
      ),
    );
  }
}
