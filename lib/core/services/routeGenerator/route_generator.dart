import 'dart:ui';

import 'package:college_super_admin_app/features/auth_module/presentation/signin_screen.dart';
import 'package:college_super_admin_app/features/dashboard_module/fees_collection_report_module/presentation/fees_collection_report_by_course.dart';
import 'package:college_super_admin_app/features/dashboard_module/fees_collection_report_module/presentation/fees_collection_report_students.dart';
import 'package:college_super_admin_app/features/dashboard_module/models/semester_details_model.dart';
import 'package:college_super_admin_app/features/dashboard_module/presentation/buttom_navigation.dart';
import 'package:college_super_admin_app/features/dashboard_module/presentation/course_wise_due%20report_screen.dart';
import 'package:college_super_admin_app/features/dashboard_module/presentation/dashboard_screen.dart';
import 'package:college_super_admin_app/features/dashboard_module/presentation/student_details_due_screen.dart';
import 'package:college_super_admin_app/features/report_module/presentation/admission_report_screen.dart';
import 'package:college_super_admin_app/features/report_module/presentation/attendance_report_screen.dart';
import 'package:college_super_admin_app/features/report_module/presentation/examination_screen.dart';
import 'package:college_super_admin_app/features/report_module/presentation/fees_collection_report_screen.dart';
import 'package:college_super_admin_app/features/report_module/presentation/fees_due_report_screen.dart';
import 'package:college_super_admin_app/features/report_module/presentation/revenue_report_screen.dart';
import 'package:college_super_admin_app/features/report_module/presentation/transaction_report_screen.dart';
import 'package:college_super_admin_app/features/splash_screen.dart';
import 'package:flutter/material.dart';
import '../../utils/helper/app_fontSize.dart';

class RouteGenerator{

  // general navigation
  static const kSplash = "/";
  static const kSigninScreen = "/SigninScreen";
  static const kDashboardScreen = "/DashboardScreen";
  static const kAdmissionReportScreen = "/AdmissionReportScreen";
  static const kTransactionReportScreen = "/TransactionReportScreen";
  static const kAttendanceReportScreen = "/AttendanceReportScreen";
  static const kExaminationScreen = "/ExaminationScreen";
  static const kFeesCollectionReportScreen = "/FeesCollectionReportScreen";
  static const kFeesDueReportScreen = "/FeesDueReportScreen";
  static const kRevenueReportScreen = "/RevenueReportScreen";
  static const kBottomNavbar = "/BottomNavbar";
  static const kCourseWiseDueReportScreen = "/CourseWiseDueReportScreen";
  static const kStudentDetailsDueScreen = "/StudentDetailsDueScreen";
  static const kFeesCollectionReportByCourse = "/FeesCollectionReportByCourse";
  static const kFeesCollectionReportStudents = "/FeesCollectionReportStudents";






  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Route<dynamic> generateRoute(RouteSettings settings){

    final args = settings.arguments;
    switch(settings.name){

      case kSplash:
        //return MaterialPageRoute(builder: (_)=>SplashScreen());
        return _animatedPageRoute(SplashScreen());
      case kSigninScreen:
        return _animatedPageRoute(SigninScreen());
      case kDashboardScreen:
        return _animatedPageRoute(DashboardScreen());
      case kBottomNavbar:
        return _animatedPageRoute(BottomNavbar());
       case kFeesCollectionReportStudents:
         final args = settings.arguments as Map<String, dynamic>;
        return _animatedPageRoute(FeesCollectionReportStudents(
          paymentDate: args['paymentDate'],
          courseId: args['course_id'],
          semesterId: args['semester_id'],
        ));
       case kFeesCollectionReportByCourse:
        return _animatedPageRoute(FeesCollectionReportByCourse(date: args as String,));
      case kCourseWiseDueReportScreen:
        return _animatedPageRoute(CourseWiseDueReportScreen(sessionId: args as int,));
      case kStudentDetailsDueScreen:
        return _animatedPageRoute(StudentDetailsDueScreen(semesterDetailsData: args as SemesterDetailsByCourseModel,));



      default:
        return _errorRoute(errorMessage: "Route not found: ${settings.name}");

    }

  }

  static Route<dynamic> _animatedPageRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return page;  // The page to navigate to
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Define the transition animation

        // Slide from the right (Offset animation)
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        final curve = Curves.easeInToLinear;  // A more natural easing curve

        var offsetTween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(offsetTween);

        // Scale transition (page zooms in slightly)
        var scaleTween = Tween(begin: 0.95, end: 1.0);
        var scaleAnimation = animation.drive(scaleTween);

        // Fade transition (opacity increases from 0 to 1)
        var fadeTween = Tween(begin: 0.0, end: 1.0);
        var fadeAnimation = animation.drive(fadeTween);

        // Return a combination of Slide, Fade, and Scale
        return SlideTransition(
          position: offsetAnimation,
          child: FadeTransition(
            opacity: fadeAnimation,
            child: ScaleTransition(
              scale: scaleAnimation,
              child: Material(
                color: Colors.transparent,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Add blur effect
                  child: child,
                ),
              ),
            ),
          ),
        );

      },
    );
  }




  static Route<dynamic> _errorRoute(
      {
        String errorMessage = '',
      }
      ) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Error",
            style: Theme.of(_)
                .textTheme
                .displayMedium
                ?.copyWith(color: Colors.black),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Text(
                "Oops something went wrong",
                style: Theme.of(_).textTheme.displayMedium?.copyWith(
                    fontSize: AppFontSize.textExtraLarge,
                    color: Colors.black),
              ),
              Text(
                errorMessage,
                style: Theme.of(_).textTheme.displayMedium?.copyWith(
                    fontSize: AppFontSize.textExtraLarge,
                    color: Colors.black),
              ),
            ],
          ),
        ),
      );
    });
  }
}