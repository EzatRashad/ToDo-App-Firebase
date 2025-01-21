import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:fire_todo/core/themes/colors.dart';
import 'package:fire_todo/presentation/screens/layout_screen/layout_screen.dart';
import 'package:flutter/material.dart';

import '../register_screen/register_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const String routeName = "Splash_route";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backLight,
      body: AnimatedSplashScreen(
        splash:Image.asset(
          'assets/images/check.png',
          fit: BoxFit.contain,
          height: 200,
          width: 200,
          alignment: Alignment.center,
        ),
        splashIconSize: double.infinity,

        nextScreen: const RegisterScreen(),
        //splashTransition: SplashTransition.scaleTransition,
      ),
    );
  }
}
