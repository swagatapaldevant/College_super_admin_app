import 'package:college_super_admin_app/core/utils/constants/app_colors.dart';
import 'package:college_super_admin_app/core/utils/helper/screen_utils.dart';
import 'package:college_super_admin_app/features/dashboard_module/widgets/bar_chart.dart';
import 'package:college_super_admin_app/features/dashboard_module/widgets/dashboard_small_container.dart';
import 'package:college_super_admin_app/features/dashboard_module/widgets/dashboard_small_progress_section_container.dart';
import 'package:college_super_admin_app/features/dashboard_module/widgets/fees_received_current_balance_widget.dart';
import 'package:college_super_admin_app/features/dashboard_module/widgets/full_details_fees_collection_container.dart';
import 'package:college_super_admin_app/features/dashboard_module/widgets/new_admission_container.dart';
import 'package:college_super_admin_app/features/dashboard_module/widgets/total_fees_received_container.dart';
import 'package:flutter/material.dart';

class FeesReceivedContainer extends StatefulWidget {
  const FeesReceivedContainer({super.key});

  @override
  State<FeesReceivedContainer> createState() => _FeesReceivedContainerState();
}

class _FeesReceivedContainerState extends State<FeesReceivedContainer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FeesReceivedCurrentBalanceWidget(),
          SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),
          TotalFeesReceivedContainer(),
          SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),
          FullDetailsFeesCollectionContainer(),
          SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),


        ],
      ),
    );
  }
}
