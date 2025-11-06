import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../repositories/auth_repository.dart';
import '../../../utils/local_storage.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final AuthRepository authRepo;

  AuthBlocBloc({required this.authRepo}) : super(AuthInitialState()) {
    on<AppStarted>(_onAppStarted);
    on<CompleteWelcomeEvent>(_onCompleteWelcome);
    on<LoginRequested>(_onLoginRequested);
    on<SignupRequested>(_onSignupRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onAppStarted(
      AppStarted event, Emitter<AuthBlocState> emit) async {
    // Show splash while checking
    emit(AuthInitialState());

    final bool? firstTime = await LocalStorage.getBool('firstTimeUser');
    if (firstTime == null || firstTime == true) {
      // Show welcome
      emit(AuthShowWelcomeState());
      return;
    }

    // not first time - check token
    final token = await LocalStorage.getString('authToken');
    if (token != null && token.isNotEmpty) {
      emit(AuthAuthenticatedState(
          token:
              token)); //if we dont have aauth token in the shared prefderence  then it should go to lgin page

      return;
    }

    emit(
        AuthUnauthenticatedState()); //if it has authenticated token then it should go to home page
  }

  Future<void> _onCompleteWelcome(
      CompleteWelcomeEvent event, Emitter<AuthBlocState> emit) async {
    await LocalStorage.setBool('firstTimeUser', false);
    emit(AuthUnauthenticatedState());
  }

  Future<void> _onLoginRequested(
      LoginRequested event, Emitter<AuthBlocState> emit) async {
    emit(AuthLoadingState(action: AuthAction.login));
    try {
      final token = await authRepo.login(event.email, event.password);
      final accessToken = token;
      final email = event.email;
      await LocalStorage.setString('authToken', accessToken);
      await LocalStorage.setString('email', email);

      emit(AuthAuthenticatedState(token: token)); //Testing token[0]
    } catch (e) {
      print(e.toString());
      emit(AuthFailureState(message: e.toString()));
      emit(AuthUnauthenticatedState());
    }
  }

  Future<void> _onSignupRequested(
      SignupRequested event, Emitter<AuthBlocState> emit) async {
    emit(AuthLoadingState(action: AuthAction.signup));
    try {
      final token = await authRepo.signup(
          username: event.email, password: event.password);
      final accessToken = token;
      final email = event.email; // use entered email (not from API)
      await LocalStorage.setString('authToken', accessToken);
      await LocalStorage.setString('email', email);
      emit(AuthAuthenticatedState(token: accessToken));
    } catch (e) {
      emit(AuthFailureState(message: e.toString()));
      emit(AuthUnauthenticatedState());
    }
  }

  Future<void> _onLogoutRequested(
      LogoutRequested event, Emitter<AuthBlocState> emit) async {
    emit(AuthLoadingState(action: AuthAction.logout));
    await LocalStorage.remove('authToken');
    // After logout go to LoginOrSign
    emit(AuthUnauthenticatedState());
  }
}
