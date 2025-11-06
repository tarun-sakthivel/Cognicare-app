import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Bloc/AuthBloc/bloc/auth_bloc_bloc.dart';
import 'Bloc/Ques/questions_bloc.dart';
import 'Screens/Home.dart';
import 'Screens/starter.dart';
import 'Screens/welcomeScreen.dart';
import 'repositories/auth_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final authRepo = AuthRepository();
  await SharedPreferences.getInstance();
  runApp(MyApp(authRepo: authRepo));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepo;
  const MyApp({super.key, required this.authRepo});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBlocBloc>(
          create: (_) => AuthBlocBloc(authRepo: authRepo)..add(AppStarted()),
        ),
        BlocProvider<QuestionsBloc>(
          create: (_) => QuestionsBloc()..add(StartQuestionsEvent()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Modular BLoC Auth',
        home: AppEntryPoint(),
      ),
    );
  }
}

/// Handles navigation based on auth state
class AppEntryPoint extends StatelessWidget {
  const AppEntryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBlocBloc, AuthBlocState>(
      builder: (context, state) {
        if (state is AuthInitialState) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is AuthShowWelcomeState) {
          return const WelcomeScreen();
        }

        if (state is AuthAuthenticatedState) {
          return HomePage();
        }

        // AuthUnauthenticatedState or errors
        return const Starter();
      },
    );
  }
}
