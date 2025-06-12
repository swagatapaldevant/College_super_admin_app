import 'package:college_super_admin_app/core/utils/constants/app_colors.dart';
import 'package:college_super_admin_app/core/utils/helper/app_dimensions.dart';
import 'package:college_super_admin_app/features/dashboard_module/presentation/due_report_dashboard_screen_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dashboard_screen.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  late final List<Widget> _screens;
  late final List<AnimationController> _fadeControllers;
  late final List<Animation<double>> _fadeAnimations;
  DateTime? currentBackPressTime;

  @override
  void initState() {
    super.initState();

    _screens = const [
      // CustomShimmer(
      //   height: 100,
      //   width: double.infinity,
      //   radius: 12,
      // ),
      DueReportDashboardScreenDetails(),
      DashboardScreen()
    ];

    // Initialize fade animations for each screen
    _fadeControllers = List.generate(
      _screens.length,
          (index) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      )..forward(),
    );

    _fadeAnimations = _fadeControllers
        .map(
          (controller) => Tween<double>(begin: 0, end: 1).animate(controller),
    )
        .toList();
  }

  void _onTabTapped(int index) {
    if (_currentIndex == index) return;

    // Fade out old screen
    _fadeControllers[_currentIndex].reverse();

    setState(() => _currentIndex = index);

    // Fade in new screen
    _fadeControllers[_currentIndex].forward();
  }

  @override
  void dispose() {
    for (var controller in _fadeControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        DateTime now = DateTime.now();
        if (didPop ||
            currentBackPressTime == null ||
            now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
          currentBackPressTime = now;
          Fluttertoast.showToast(msg: 'Tap back again to Exit');
          // return false;
        } else {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: List.generate(_screens.length, (index) {
            return FadeTransition(
              opacity: _fadeAnimations[index],
              child: _screens[index],
            );
          }),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: AppColors.white, width: 2.0)),
            color: AppColors.gray3.withOpacity(0.9),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 20),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: _onTabTapped,
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            selectedItemColor: AppColors.alphabetFunContainer,
            unselectedItemColor: AppColors.gray7,
            selectedFontSize: 14,
            unselectedFontSize: 14,
            selectedLabelStyle: TextStyle(
              fontFamily: "Roboto",
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: TextStyle(
              fontFamily: "Roboto",
              fontWeight: FontWeight.w500,
            ),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined, size: 30),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_rounded, size: 30),
                label: 'Others',
              ),
            ],
          ),
        ),
      ),
    );
  }
}