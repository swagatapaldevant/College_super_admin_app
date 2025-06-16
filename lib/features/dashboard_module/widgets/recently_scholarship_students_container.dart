import 'package:college_super_admin_app/core/utils/constants/app_colors.dart';
import 'package:college_super_admin_app/core/utils/helper/screen_utils.dart';
import 'package:college_super_admin_app/features/dashboard_module/models/recently_scholarship_student.dart';
import 'package:flutter/material.dart';

class RecentlyScholarshipStudentsContainer extends StatefulWidget {
  final List<RecentlyScholarshipStudent> studentList;
   const RecentlyScholarshipStudentsContainer({super.key, required this.studentList});

  @override
  State<RecentlyScholarshipStudentsContainer> createState() =>
      _RecentlyScholarshipStudentsContainerState();
}

class _RecentlyScholarshipStudentsContainerState
    extends State<RecentlyScholarshipStudentsContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtils().screenHeight(context) * 0.5,
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
                Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                      itemCount: widget.studentList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return studentData("${widget.studentList[index].firstName}  ${widget.studentList[index].lastName}", widget.studentList[index].identificationNo.toString());
                      }),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: ScreenUtils().screenHeight(context) * 0.07,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    //Colors.transparent,
                    Colors.white
                        .withOpacity(0.1),
                    Colors.white
                        .withOpacity(0.3), // You can adjust the opacity/color
                    Colors.white
                        .withOpacity(0.5), // You can adjust the opacity/color
                    Colors.white
                        .withOpacity(0.7),
                    Colors.white
                        .withOpacity(0.9), // You can adjust the opacity/color
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

  Widget studentData(String studentName, String studentId) {
    return Column(
      children: [
        Row(
          mainAxisAlignment:MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // CircleAvatar(
                //   radius: 22,
                //   backgroundImage: NetworkImage(
                //       "https://media.istockphoto.com/id/1351018006/photo/smiling-male-student-sitting-in-university-classroom.jpg?s=612x612&w=0&k=20&c=G9doLib_ILUijluTSD5hstZBWqHHIcw4dBHhQcs-ON4="),
                // ),
                // SizedBox(
                //   width: 10,
                // ),
                Text(
                  studentName,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      fontFamily: "Poppins",
                      color: AppColors.colorBlack),
                ),
              ],
            ),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.progressBarColor,
              ),

              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                child: Text(
                  studentId,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                      fontFamily: "Poppins",
                      color: AppColors.white),
                ),
              ),
            ),
            // SizedBox(
            //   width: ScreenUtils().screenWidth(context) * 0.2,
            // ),
            // Row(
            //   children: [
            //     Icon(
            //       Icons.check_box,
            //       color: AppColors.blue,
            //       size: 20,
            //     ),
            //     SizedBox(
            //       width: 5,
            //     ),
            //     // Column(children: [
            //     //   Text(
            //     //     "VII - A",
            //     //     style: TextStyle(
            //     //         fontWeight: FontWeight.w600,
            //     //         fontSize: 14,
            //     //         color: AppColors.blue),
            //     //   ),
            //     //   Text(
            //     //     "Class 7",
            //     //     style: TextStyle(
            //     //         fontWeight: FontWeight.w400,
            //     //         fontSize: 10,
            //     //         color: AppColors.gray7),
            //     //   ),
            //     // ])
            //   ],
            // )
          ],
        ),
        Divider(
          color: AppColors.gray3,
        ),
      ],
    );
  }
}
