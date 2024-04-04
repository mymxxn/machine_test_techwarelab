part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignUpRequested extends AuthenticationEvent {
  final String name;
  final String email;
  final String password;

  SignUpRequested(this.name, this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class SignInRequested extends AuthenticationEvent {
  final String email;
  final String password;

  SignInRequested(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class CheckLoggedIn extends AuthenticationEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
