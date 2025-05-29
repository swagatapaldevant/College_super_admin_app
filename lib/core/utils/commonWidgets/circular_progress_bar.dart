import 'package:college_super_admin_app/core/utils/helper/screen_utils.dart';
import 'package:flutter/material.dart';

class CircularProgressBar extends StatelessWidget {
  final double value; // Between 0.0 and 1.0
  final Duration duration;
  final Color? color;


  const CircularProgressBar({
    super.key,
    required this.value,
    this.color,
    this.duration = const Duration(seconds: 2),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 60,
      //width: 100,
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0.0, end: value),
        duration: duration,
        builder: (context, animatedValue, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: ScreenUtils().screenHeight(context)*0.05,
                width: ScreenUtils().screenWidth(context)*0.1,
                child: CircularProgressIndicator(
                  value: animatedValue,
                  strokeWidth: 5,
                  backgroundColor: Colors.grey.shade300,
                  valueColor: AlwaysStoppedAnimation<Color>(color??Colors.blue),
                ),
              ),
              Text(
                '${(animatedValue * 100).toStringAsFixed(0)}%',
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
