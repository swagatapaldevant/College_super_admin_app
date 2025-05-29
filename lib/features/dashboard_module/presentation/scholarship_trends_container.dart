import 'package:college_super_admin_app/core/utils/constants/app_colors.dart';
import 'package:college_super_admin_app/core/utils/helper/screen_utils.dart';
import 'package:college_super_admin_app/features/dashboard_module/widgets/new_admission_container.dart';
import 'package:college_super_admin_app/features/dashboard_module/widgets/recently_scholarship_students_container.dart';
import 'package:college_super_admin_app/features/dashboard_module/widgets/scholarship_trends_graph.dart';
import 'package:flutter/material.dart';

class ScholarshipTrendsContainer extends StatefulWidget {
  const ScholarshipTrendsContainer({super.key});

  @override
  State<ScholarshipTrendsContainer> createState() => _ScholarshipTrendsContainerState();
}

class _ScholarshipTrendsContainerState extends State<ScholarshipTrendsContainer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScholarshipTrendsGraph(),
          SizedBox(height: ScreenUtils().screenHeight(context)*0.015,),
          Text("Recently Scholarship Students", style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.colorBlack,
          ),),
          SizedBox(height: ScreenUtils().screenHeight(context)*0.015,),
          RecentlyScholarshipStudentsContainer(),
          SizedBox(height: ScreenUtils().screenHeight(context)*0.03,),


        ],
      ),
    );
  }
}
