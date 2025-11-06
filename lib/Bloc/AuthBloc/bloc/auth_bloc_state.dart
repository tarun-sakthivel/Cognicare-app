part of 'auth_bloc_bloc.dart';

// @immutable
// sealed class AuthBlocState {}

// final class AuthBlocInitial extends AuthBlocState {}

enum AuthAction { none, login, signup, logout }

abstract class AuthBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthBlocState {}
class AuthShowWelcomeState extends AuthBlocState {}
class AuthUnauthenticatedState extends AuthBlocState {}

class AuthLoadingState extends AuthBlocState {
  final AuthAction action;
  AuthLoadingState({this.action = AuthAction.none});

  @override
  List<Object?> get props => [action];
}

class AuthAuthenticatedState extends AuthBlocState {
  final String token;
  AuthAuthenticatedState({required this.token});
  @override
  List<Object?> get props => [token];
}

class AuthFailureState extends AuthBlocState {
  final String message;
  AuthFailureState({required this.message});
  @override
  List<Object?> get props => [message];
}