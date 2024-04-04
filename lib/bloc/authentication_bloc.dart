import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_test_techware/Data/Repositories/auth_repository.dart';
import 'package:machine_test_techware/Presentation/Utils/route_manager.dart';
import 'package:machine_test_techware/Presentation/Utils/shared_preferences.dart';
import 'package:machine_test_techware/Presentation/Utils/snackbar_services.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository authRepository;

  AuthenticationBloc({required this.authRepository})
      : super(AuthenticationInitial()) {
    on<SignUpRequested>((event, emit) async {
      try {
        await authRepository.signUp(
            name: event.name, email: event.email, password: event.password);
        log("message signup");
        emit(SignedUp());
      } catch (error) {
        log("AuthenticationFailed ${error.toString()}");
        emit(AuthenticationFailed(error: error.toString()));
      }
    });
    on<SignInRequested>((event, emit) async {
      try {
        await authRepository.signIn(
            email: event.email, password: event.password);
        emit(SignedIn());
      } catch (error) {
        log(error.toString());
        emit(AuthenticationFailed(error: error.toString()));
      }
    });
    
  }
}
