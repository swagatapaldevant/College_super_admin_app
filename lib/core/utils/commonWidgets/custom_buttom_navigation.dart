import 'package:college_super_admin_app/core/utils/helper/app_dimensions.dart';
import 'package:college_super_admin_app/core/utils/helper/screen_utils.dart';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    return Padding(
      padding:  EdgeInsets.only(
          left:AppDimensions.screenPadding,
          right:AppDimensions.screenPadding,
          bottom:AppDimensions.screenPadding,
      ),
      child: Container(
        height: ScreenUtils().screenHeight(context)*0.11,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF5BE),
          borderRadius:  BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFFFED8C),
              offset: const Offset(0, 4),
              blurRadius: 0
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavItem("assets/images/home.png", 0, "Home", context),
            _buildNavItem("assets/images/puzzle.png", 1, "Game", context),
            _buildNavItem("assets/images/star.png", 2, "Achievement", context),
            _buildNavItem("assets/images/teddy.png", 3, "Profile", context),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String iconPath, int index, String label, BuildContext context) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.translationValues(0, isSelected ? -20 : 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              //margin: const EdgeInsets.only(bottom: 5),
              width: ScreenUtils().screenHeight(context)*0.075,
              height:  ScreenUtils().screenHeight(context)*0.075,
              decoration: BoxDecoration(
                color: AppColors.navbarItemColor.withOpacity(0.74),
                borderRadius: BorderRadius.circular(20),
                boxShadow: isSelected
                    ? [
                  BoxShadow(
                    color: AppColors.navbarItemColorDown,
                    offset: const Offset(0, 6),
                    blurRadius: 0,
                  )
                ]
                    : [],
              ),
              child: Center(
                child: Image.asset(
                  iconPath,
                  width: ScreenUtils().screenHeight(context)*0.06,
                  height: ScreenUtils().screenHeight(context)*0.06,
                ),
              ),
            ),
            SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),
            if (isSelected)
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Kavoon',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.navbarItemColor.withOpacity(0.74),
                ),
              )
          ],
        ),
      ),
    );
  }

}
