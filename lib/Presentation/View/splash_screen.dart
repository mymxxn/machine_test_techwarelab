import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:machine_test_techware/Presentation/Utils/components.dart';
import 'package:machine_test_techware/Presentation/Utils/constants.dart';
import 'package:machine_test_techware/Presentation/Utils/route_manager.dart';
import 'package:machine_test_techware/Presentation/Utils/shared_preferences.dart';
import 'package:machine_test_techware/Presentation/View/pin_login_screen.dart';
import 'package:machine_test_techware/bloc/authentication_bloc.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 1)).then((value) => _checkLoggedIn());
    });
  }

  void _checkLoggedIn() {
    bool isLoggedIn = UserPreferences.getIsLoggedIn() ?? false;

    if (isLoggedIn) {
      if (UserPreferences.getPin() == null || UserPreferences.getPin() == 0) {
        Navigator.pushReplacementNamed(context, RouteManager.pinLoginScreen);
        Components.commonDialog(
          context,
          "Set Pin Number",
          OtpTextField(
            numberOfFields: 4,
            borderColor: Color(0xFF512DA8),
            showFieldAsBox: true,
            onCodeChanged: (String code) {
              // handle validation or checks here
            },
            onSubmit: (String verificationCode) {
              UserPreferences.setPin(int.parse(verificationCode));
              Navigator.pop(context);
            },
          ),
        );
      } else {
        Navigator.pushReplacementNamed(context, RouteManager.pinLoginScreen);
      }
    } else {
      Navigator.pushReplacementNamed(context, RouteManager.signInScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(color: AppColors.primary,
          child: Center(
              child: Text(
        "Welcome",
        style: TextStyle(fontSize: 25, color: Colors.white),
      ))),
    );
  }
}
