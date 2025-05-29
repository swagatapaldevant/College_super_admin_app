import 'package:college_super_admin_app/core/utils/constants/app_colors.dart';
import 'package:college_super_admin_app/core/utils/helper/screen_utils.dart';
import 'package:flutter/material.dart';

class FullDetailsFeesCollectionContainer extends StatefulWidget {
  const FullDetailsFeesCollectionContainer({super.key});

  @override
  State<FullDetailsFeesCollectionContainer> createState() =>
      _FullDetailsFeesCollectionContainerState();
}

class _FullDetailsFeesCollectionContainerState
    extends State<FullDetailsFeesCollectionContainer> {
  final String name = "Swagata Pal";

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
                  color: AppColors.colorBlack),
            ),
            SizedBox(
              height: ScreenUtils().screenHeight(context) * 0.015,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 9,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
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
                                          color: AppColors.colorBlack),
                                    ),
                                    Text(
                                      'ID 123447',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10,
                                          color: AppColors.gray7),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'VII-A\n',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: AppColors.blue),
                                children: const <TextSpan>[
                                  TextSpan(
                                      text: 'Class - 7',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10,
                                          color: AppColors.gray7)),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Admission\n',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                    color: AppColors.colorBlack),
                                children: const <TextSpan>[
                                  TextSpan(
                                      text: '27-5-25',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10,
                                          color: AppColors.gray7)),
                                ],
                              ),
                            ),
                            Text(
                              '₹ 10,500.00',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
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
