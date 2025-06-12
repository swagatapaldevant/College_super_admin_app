import 'package:college_super_admin_app/core/utils/constants/app_colors.dart';
import 'package:college_super_admin_app/core/utils/helper/screen_utils.dart';
import 'package:college_super_admin_app/features/dashboard_module/models/fees_collection_by_student_model.dart';
import 'package:flutter/material.dart';

class FullDetailsFeesCollectionContainer extends StatefulWidget {
  final List<FeesCollectionBystudentModel> studentList;
  const FullDetailsFeesCollectionContainer({super.key, required this.studentList});

  @override
  State<FullDetailsFeesCollectionContainer> createState() =>
      _FullDetailsFeesCollectionContainerState();
}

class _FullDetailsFeesCollectionContainerState
    extends State<FullDetailsFeesCollectionContainer> {


  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtils().screenHeight(context) * 0.5,
      width: ScreenUtils().screenWidth(context),
      decoration: BoxDecoration(
        color: AppColors.white,
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
        padding: EdgeInsets.only(
          top: ScreenUtils().screenWidth(context) * 0.04,
          right: ScreenUtils().screenWidth(context) * 0.04,
          left: ScreenUtils().screenWidth(context) * 0.04,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Full details of fees collection by student",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Poppins",
                  color: AppColors.colorBlack),
            ),
            SizedBox(
              height: ScreenUtils().screenHeight(context) * 0.015,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.studentList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final String name = "${widget.studentList[index].firstName} ${widget.studentList[index].lastName}";
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: ScreenUtils().screenWidth(context)*0.5,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundImage: NetworkImage(
                                        "https://plus.unsplash.com/premium_photo-1689568126014-06fea9d5d341?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D"),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    spacing: 2,
                                    children: [
                                      Text(
                                        name.length > 13 ? '${name.substring(0, 13)}...' : name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            fontFamily: "Poppins",
                                            color: AppColors.colorBlack),
                                      ),
                                      Text(
                                        widget.studentList[index].identificationNo.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10,
                                            fontFamily: "Poppins",
                                            color: AppColors.gray7),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            // RichText(
                            //   text: TextSpan(
                            //     text: 'VII-A\n',
                            //     style: TextStyle(
                            //         fontWeight: FontWeight.w600,
                            //         fontSize: 12,
                            //         color: AppColors.blue),
                            //     children: const <TextSpan>[
                            //       TextSpan(
                            //           text: 'Class - 7',
                            //           style: TextStyle(
                            //               fontWeight: FontWeight.w500,
                            //               fontSize: 10,
                            //               color: AppColors.gray7)),
                            //     ],
                            //   ),
                            // ),
                            RichText(
                              text: TextSpan(
                                text: 'Paid on\n',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                    fontFamily: "Poppins",
                                    color: AppColors.colorBlack),
                                children:  <TextSpan>[
                                  TextSpan(
                                      text: widget.studentList[index].paidOn.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10,
                                          fontFamily: "Poppins",
                                          color: AppColors.gray7)),
                                ],
                              ),
                            ),
                            Text(
                              '₹ ${widget.studentList[index].amount.toString()}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Poppins",
                                  fontSize: 11,
                                  color: AppColors.colorBlack),
                            )
                          ],
                        ),
                        Divider(
                          color: AppColors.gray3,
                        )
                      ],
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
