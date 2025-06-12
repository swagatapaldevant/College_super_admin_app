import 'package:college_super_admin_app/core/network/apiHelper/locator.dart';
import 'package:college_super_admin_app/core/network/apiHelper/resource.dart';
import 'package:college_super_admin_app/core/network/apiHelper/status.dart';
import 'package:college_super_admin_app/core/services/localStorage/shared_pref.dart';
import 'package:college_super_admin_app/core/utils/commonWidgets/common_button.dart';
import 'package:college_super_admin_app/core/utils/commonWidgets/custom_textField.dart';
import 'package:college_super_admin_app/core/utils/helper/common_utils.dart';
import 'package:college_super_admin_app/features/auth_module/data/auth_usecase.dart';
import 'package:flutter/material.dart';
import 'package:college_super_admin_app/core/utils/constants/app_colors.dart';
import 'package:college_super_admin_app/core/utils/helper/screen_utils.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool rememberMe = false;
  bool obscureText = true;
  bool isLoading = false;
  final AuthUsecase _authUsecase = getIt<AuthUsecase>();
  final SharedPref _pref = getIt<SharedPref>();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Interval(0.2, 1.0, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Top background image
            Image.asset(
              "assets/images/signin.png",
              width: ScreenUtils().screenWidth(context),
              height: ScreenUtils().screenHeight(context) * 0.45,
              fit: BoxFit.cover,
            ),

            Column(
              children: [
                SizedBox(height: ScreenUtils().screenHeight(context) * 0.35),

                // Main content container
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      // Email field
                      _animatedChild(
                          index: 0,
                          child: CustomTextField(
                              controller: emailController,
                              hintText: "Enter your email",
                              prefixIcon: Icons.email)),
                      SizedBox(
                          height: ScreenUtils().screenHeight(context) * 0.015),

                      _animatedChild(
                        index: 1,
                        child: CustomTextField(
                          controller: passwordController,
                          hintText: 'Password',
                          prefixIcon: Icons.lock,
                          suffixIcon: Icons.visibility,
                          isPassword: true,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Remember me and Forgot Password
                      _animatedChild(
                        index: 2,
                        child: Row(
                          children: [
                            Checkbox(
                              value: rememberMe,
                              onChanged: (val) {
                                setState(() {
                                  rememberMe = val!;
                                });
                              },
                            ),
                            const Text(
                              "Remember me",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins",
                                  color: AppColors.colorBlack,
                                  fontSize: 14),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {},
                              child: const Text(
                                "Forgot Password ?",
                                style: TextStyle(
                                    color: AppColors.gray7,
                                    fontSize: 14,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                          height: ScreenUtils().screenHeight(context) * 0.05),

                      // Log In Button
                      _animatedChild(
                          index: 3,
                          child: isLoading
                              ? CircularProgressIndicator(
                                  color: AppColors.blue,
                                )
                              : CommonButton(
                                  onTap: () {
                                    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty)
                                      {
                                        loginAdmin();
                                      }
                                    else{
                                      CommonUtils().flutterSnackBar(
                                          context: context, mes:"Please enter email and password", messageType: 4);

                                    }

                                  },
                                  height: 48,
                                  width: ScreenUtils().screenWidth(context),
                                  buttonName: "Signin",
                                  fontSize: 16,
                                  borderRadius: 10,
                                  buttonTextColor: AppColors.white,
                                  gradientColor1: AppColors.blue,
                                  gradientColor2:
                                      AppColors.blue.withOpacity(0.5))),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _animatedChild({required int index, required Widget child}) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: _controller,
        curve: Interval(0.2 + index * 0.1, 1.0, curve: Curves.easeIn),
      ),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.3),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: _controller,
          curve: Interval(0.2 + index * 0.1, 1.0, curve: Curves.easeOut),
        )),
        child: child,
      ),
    );
  }

  loginAdmin() async {
    setState(() {
      isLoading = true;
    });

    Map<String, dynamic> requestData = {
      "email": emailController.text.trim(),
      "password": passwordController.text.trim()
    };
    // {
    //   "email": "admin@admin.com",
    //   "password": "12345678"
    // };

    Resource resource = await _authUsecase.logIn(requestData: requestData);

    if (resource.status == STATUS.SUCCESS) {
      _pref.setLoginStatus(true);
      _pref.setUserAuthToken(resource.data["token"]);
      _pref.setProfileImage(resource.data['image']);
      _pref.setUserName(
          resource.data['first_name'] +" "+ resource.data['last_name']);
      if (resource.data['user_type_id'] == 1) {
        Navigator.pushNamed(context, "/BottomNavbar");
      }
      else{
        CommonUtils().flutterSnackBar(
            context: context, mes:"You are not an admin, you have not permission to view the app", messageType: 4);
      }

    } else {
      setState(() {
        isLoading = false;
      });
      CommonUtils().flutterSnackBar(
          context: context, mes: resource.message ?? "", messageType: 4);
    }
  }
}
