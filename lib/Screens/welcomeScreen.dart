import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/AuthBloc/bloc/auth_bloc_bloc.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            image: DecorationImage(
              image: AssetImage('assets/Images/logo.png'),
              fit: BoxFit.contain,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                Text('Welcome to',
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(fontSize: 50)),

                // Text('Something App', style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 40)),
                //Image.asset("assets/logo/expensio.png",scale:10,),
                const SizedBox(height: 8),
                Text(
                    'An intelligent tool to help detect early signs of autism in children.Gain insights, track assessments, and support your child’s developmental journey.',
                    style: Theme.of(context).textTheme.bodyMedium),
                const Spacer(),
                GestureDetector(
                    onTap: () {
                      // Mark first time completed
                      context.read<AuthBlocBloc>().add(CompleteWelcomeEvent());
                    },
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                          child: Text("Next",
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimary))),
                    )),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
