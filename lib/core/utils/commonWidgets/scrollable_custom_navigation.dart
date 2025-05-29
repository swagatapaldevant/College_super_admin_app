import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../helper/app_dimensions.dart';
import '../helper/screen_utils.dart';

class ScrollableCustomNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const ScrollableCustomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    return Padding(
      padding: EdgeInsets.only(
        left: AppDimensions.screenPadding,
        right: AppDimensions.screenPadding,
        bottom: AppDimensions.screenPadding,
      ),
      child: Container(
        height: ScreenUtils().screenHeight(context) * 0.11,
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFE0),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFFFED8C),
              offset: const Offset(0, 4),
              blurRadius: 0,
            ),
          ],
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                _buildNavItem("assets/images/home.png", 0, "Home", context),
                _buildNavItem("assets/images/learning_module_navbar/navbar_vowel.png", 1, "Vowel", context),
                _buildNavItem("assets/images/learning_module_navbar/navbar_consonant.png", 2, "Consonant", context),
                _buildNavItem("assets/images/learning_module_navbar/navbar_numeric.png", 3, "Numerics", context),
                // _buildNavItem("assets/images/settings.png", 3, "Number", context),
                // _buildNavItem("assets/images/settings.png", 4, "Settings", context),
                // _buildNavItem("assets/images/settings.png", 5, "Settings1", context),
                // _buildNavItem("assets/images/settings.png", 6, "Settings2", context),

                // Add more items here!
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(String iconPath, int index, String label, BuildContext context) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          transform: Matrix4.translationValues(0, isSelected ? -10 : 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: ScreenUtils().screenHeight(context) * 0.075,
                height: ScreenUtils().screenHeight(context) * 0.075,
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
                    width: ScreenUtils().screenHeight(context) * 0.06,
                    height: ScreenUtils().screenHeight(context) * 0.06,
                  ),
                ),
              ),
              SizedBox(height: ScreenUtils().screenHeight(context) * 0.01),
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
      ),
    );
  }
}

