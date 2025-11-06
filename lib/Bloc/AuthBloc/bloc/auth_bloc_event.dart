part of 'auth_bloc_bloc.dart';


abstract class AuthBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppStarted extends AuthBlocEvent {}
class CompleteWelcomeEvent extends AuthBlocEvent {}

class LoginRequested extends AuthBlocEvent {
  final String email;
  final String password;
  LoginRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class SignupRequested extends AuthBlocEvent {

  final String email;
  final String password;
  SignupRequested({ required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class LogoutRequested extends AuthBlocEvent {}