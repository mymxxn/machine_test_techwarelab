import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:machine_test_techware/Presentation/Utils/components.dart';
import 'package:machine_test_techware/Presentation/Utils/constants.dart';
import 'package:machine_test_techware/Presentation/Utils/route_manager.dart';
import 'package:machine_test_techware/Presentation/Utils/shared_preferences.dart';
import 'package:machine_test_techware/Presentation/Utils/snackbar_services.dart';
import 'package:machine_test_techware/bloc/authentication_bloc.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(30),
          alignment: Alignment.center,
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppIcons.loginBgDesign), fit: BoxFit.fill)),
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                "Sign In",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 6,
              ),
              const Text(
                "Hi! Welcome back you have been missed.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 19,
              ),
              Components.commonTextfield(
                  txt: "Email",
                  controller: emailController,
                  inputtype: TextInputType.emailAddress),
              const SizedBox(
                height: 15,
              ),
              Components.commonTextfield(
                  txt: "Password",
                  controller: passwordController,
                  inputtype: TextInputType.visiblePassword,
                  obscureText: true),
              const SizedBox(
                height: 15,
              ),
              BlocListener<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  if (state is SignedIn) {
                    // Handle signed in state
                    emailController.clear();
                    passwordController.clear();
                    UserPreferences.setIsLoggedIn(true);
                    SnackBarServices.successSnackbar("Successfully Logged In");
                    log("${UserPreferences.getIsLoggedIn()} logged in");
                    log("${UserPreferences.getPin()} pin");

                    if (UserPreferences.getPin() == 0 ||
                        UserPreferences.getPin() == null) {
                      Navigator.pushReplacementNamed(
                          context, RouteManager.pinLoginScreen);
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
                            Get.back();
                          },
                        ),
                      );
                    } else {
                      Navigator.pushReplacementNamed(
                          context, RouteManager.pinLoginScreen);
                    }
                  } else if (state is AuthenticationFailed) {
                    // Handle authentication failed state
                    log("snack bar AuthenticationFailed ${state.error}");
                    SnackBarServices.errorSnackbar(state.error);
                  }
                },
                child: ElevatedButton(
                  onPressed: () async {
                    context.read<AuthenticationBloc>().add(
                          SignInRequested(
                            emailController.text,
                            passwordController.text,
                          ),
                        );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    fixedSize: Size(size.width, 50),
                  ),
                  child: Text(
                    "Sign In",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, RouteManager.registerationScreen);
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(color: AppColors.primary),
                      ))
                ],
              )
            ]),
          )),
    );
  }
}
