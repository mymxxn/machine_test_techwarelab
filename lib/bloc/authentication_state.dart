part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState extends Equatable {}

class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

// class SigningUp extends AuthenticationState {
//   @override
//   List<Object?> get props => [];
// }

class SignedUp extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthenticationFailed extends AuthenticationState {
  final String error;

  AuthenticationFailed({required this.error});

  @override
  List<Object?> get props => [error];
}

class SignedIn extends AuthenticationState {
  @override
  List<Object?> get props => [];
}


