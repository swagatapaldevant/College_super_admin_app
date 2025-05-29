import 'package:college_super_admin_app/core/network/apiHelper/locator.dart';
import 'package:college_super_admin_app/core/services/routeGenerator/route_generator.dart';
import 'package:college_super_admin_app/core/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDependency();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'College admin app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.white,
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      navigatorKey: RouteGenerator.navigatorKey,
      initialRoute: RouteGenerator.kSplash,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
