import 'package:college_super_admin_app/core/utils/constants/app_colors.dart';
import 'package:college_super_admin_app/core/utils/helper/screen_utils.dart';
import 'package:flutter/material.dart';

class NewAdmissionContainer extends StatefulWidget {
  const NewAdmissionContainer({super.key});

  @override
  State<NewAdmissionContainer> createState() => _NewAdmissionContainerState();
}

class _NewAdmissionContainerState extends State<NewAdmissionContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtils().screenHeight(context)*0.4,
      width: ScreenUtils().screenWidth(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.gray7.withOpacity(0.25),
            blurRadius: 4,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "New Admission",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.colorBlack),
                ),
                Text(
                  "You have new 18 admission",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: AppColors.gray7),
                ),
                SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),

                Expanded(
                  child: ListView.builder(
                    itemCount: 8,
                      itemBuilder: (BuildContext context, int index){
                        return studentData();
                      }),
                )






              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: ScreenUtils().screenHeight(context)*0.05,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    //Colors.transparent,
                    Colors.white.withOpacity(0.1), // You can adjust the opacity/color
                    Colors.white.withOpacity(0.4), // You can adjust the opacity/color
                    Colors.white.withOpacity(0.7), // You can adjust the opacity/color
                    Colors.white, // You can adjust the opacity/color
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget studentData(){
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundImage: NetworkImage("https://media.istockphoto.com/id/1351018006/photo/smiling-male-student-sitting-in-university-classroom.jpg?s=612x612&w=0&k=20&c=G9doLib_ILUijluTSD5hstZBWqHHIcw4dBHhQcs-ON4="),
            ),
            SizedBox(width: 10,),
            Column(
              children: [
                Text("Swagata Pal", style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: AppColors.colorBlack
                ),),
                Text("ID 1234565", style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    color: AppColors.gray7
                ),),
              ],
            ),
            SizedBox(width: ScreenUtils().screenWidth(context)*0.2,),

            Row(
              children: [
                Icon(Icons.check_box, color: AppColors.blue,size: 20,),
                SizedBox(width: 5,),
                Column(
                  children: [
                    Text("VII - A", style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppColors.blue
                    ),),
                    Text("Class 7", style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        color: AppColors.gray7
                    ),),
                  ]

                )
              ],
            )
          ],
        ),
        Divider(color: AppColors.gray3,),
      ],
    );
  }
}
