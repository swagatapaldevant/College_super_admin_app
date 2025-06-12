import 'package:college_super_admin_app/core/network/apiHelper/locator.dart';
import 'package:college_super_admin_app/core/services/localStorage/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:college_super_admin_app/core/utils/constants/app_colors.dart';
import 'package:college_super_admin_app/core/utils/helper/screen_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<double> _logoScaleAnimation;

  late AnimationController _textController;
  late Animation<double> _textFadeAnimation;
  final SharedPref _pref = getIt<SharedPref>();


  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();

    _logoScaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _textFadeAnimation = CurvedAnimation(
      parent: _textController,
      curve: Curves.easeIn,
    );

    // Delay before showing text
    Future.delayed(const Duration(milliseconds: 1000), () {
      _textController.forward();
    });

    // Navigation
    Future.delayed(const Duration(seconds: 3), () {
      setTimerNavigation();
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = ScreenUtils().screenHeight(context);
    final screenWidth = ScreenUtils().screenWidth(context);

    return Scaffold(
      body: Stack(
        children: [
          // Custom painted background
          CustomPaint(
            size: Size(screenWidth, screenHeight),
            painter: SplashBackgroundPainter(),
          ),

          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScaleTransition(
                  scale: _logoScaleAnimation,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.white24,
                          blurRadius: 40,
                          spreadRadius: 5,
                        ),
                      ],
                      gradient: LinearGradient(
                        colors: [AppColors.blue, AppColors.blue.withOpacity(0.5)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.admin_panel_settings,
                        size: 60,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                FadeTransition(
                  opacity: _textFadeAnimation,
                  child: Text(
                    "Welcome\nSuper Admin !!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.darkBlue,
                      fontSize: 28,

                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                      fontFamily: "Poppins"
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  void setTimerNavigation() async {
    String token = await _pref.getUserAuthToken();
    bool loginStatus = await _pref.getLoginStatus();
    String userType = await _pref.getUserType();

    try {
      if (token.length > 10 && loginStatus) {
        Navigator.pushReplacementNamed(context, "/BottomNavbar");
      }
      else{
        Navigator.pushReplacementNamed(context, "/SigninScreen");
      }

    } catch (ex) {
      Navigator.pushReplacementNamed(context, "/SigninScreen");
    }
  }
}

/// 🎨 CustomPainter for the background waves
class SplashBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..shader = LinearGradient(
        colors: [
          AppColors.blue.withOpacity(0.8),
          AppColors.blue.withOpacity(0.3),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path1 = Path()
      ..moveTo(0, size.height * 0.75)
      ..quadraticBezierTo(
          size.width * 0.3, size.height * 0.7, size.width * 0.6, size.height)
      ..lineTo(0, size.height)
      ..close();

    final paint2 = Paint()
      ..color = AppColors.blue.withOpacity(0.2);

    final path2 = Path()
      ..moveTo(size.width, size.height * 0.4)
      ..quadraticBezierTo(size.width * 0.6, size.height * 0.5, 0, size.height * 0.2)
      ..lineTo(0, 0)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path1, paint1);
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
