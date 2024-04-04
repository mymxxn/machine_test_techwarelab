import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:machine_test_techware/Presentation/Utils/shared_preferences.dart';
import 'package:machine_test_techware/Presentation/Utils/snackbar_services.dart';

class PinLogin extends StatefulWidget {
  @override
  _PinLoginState createState() => _PinLoginState();
}

class _PinLoginState extends State<PinLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PIN'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Pin'),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: OtpTextField(
                numberOfFields: 4,
                borderColor: Color(0xFF512DA8),
                //set to true to show as box or false to show as dash
                showFieldAsBox: true,
                //runs when a code is typed in
                onCodeChanged: (String code) {
                  //handle validation or checks here
                },
                //runs when every textfield is filled
                onSubmit: (String verificationCode) {
                  if (int.parse(verificationCode) == UserPreferences.getPin()) {
                    Navigator.pushReplacementNamed(context, '/home');
                  } else {
                    SnackBarServices.errorSnackbar("Wrong Pin");
                  }
                }, // end onSubmit
              ),
            ),
          ],
        ),
      ),
    );
  }
}
