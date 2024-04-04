import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test_techware/Presentation/Utils/components.dart';
import 'package:machine_test_techware/Presentation/Utils/constants.dart';
import 'package:machine_test_techware/Presentation/Utils/route_manager.dart';
import 'package:machine_test_techware/Presentation/Utils/snackbar_services.dart';
import 'package:machine_test_techware/bloc/authentication_bloc.dart';

class RegisterationScreen extends StatelessWidget {
  RegisterationScreen({super.key});
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(30),
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppIcons.loginBgDesign), fit: BoxFit.fill)),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Sign Up",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 6,
            ),
            const Text(
              "Create your new account",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 19,
            ),
            Row(
              children: [
                Expanded(
                  child: Components.commonTextfield(
                      txt: "First Name",
                      controller: firstNameController,
                      inputtype: TextInputType.text),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: Components.commonTextfield(
                        txt: "Last Name",
                        controller: lastNameController,
                        inputtype: TextInputType.text))
              ],
            ),
            const SizedBox(
              height: 15,
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
            ),
            const SizedBox(
              height: 15,
            ),
            BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state is SignedUp) {
                  // Handle signed up state
                  emailController.clear();
                  passwordController.clear();
                  SnackBarServices.successSnackbar(
                      "Successfully account created");
                  Navigator.pushReplacementNamed(
                      context, RouteManager.signInScreen);
                } else if (state is AuthenticationFailed) {
                  // Handle authentication failed state
                  log("snack bar AuthenticationFailed ${state.error}");
                  SnackBarServices.errorSnackbar(state.error);
                }
              },
              child: ElevatedButton(
                onPressed: () async {
                  // Dispatch the SignUpRequested event
                  context.read<AuthenticationBloc>().add(SignUpRequested(
                      "${firstNameController.text} ${lastNameController.text}",
                      emailController.text,
                      passwordController.text));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  fixedSize: Size(size.width, 50),
                ),
                child: Text(
                  "Sign Up",
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
                const Text("If you have an account?"),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, RouteManager.signInScreen);
                    },
                    child: const Text(
                      "Sign In",
                      style: TextStyle(color: AppColors.primary),
                    ))
              ],
            )
          ],
        ),
      ),
    ));
  }
}
