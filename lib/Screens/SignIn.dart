import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cognicare/Screens/Home.dart';
import 'package:cognicare/Screens/SignUp.dart';
import 'package:cognicare/Screens/starter.dart';
import 'package:cognicare/constants/Colors.dart';
import 'package:cognicare/constants/text.dart';

import '../Bloc/AuthBloc/bloc/auth_bloc_bloc.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int screenWidth = MediaQuery.of(context).size.width.toInt();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: kwhite,
      appBar: AppBar(
        backgroundColor: kwhite,
        title: Text(
          "Sign In",
          style: knormalTextStyle.copyWith(
              fontWeight: FontWeight.w500, fontSize: 24),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Starter()),
              (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      body: BlocConsumer<AuthBlocBloc, AuthBlocState>(
        listener: (context, state) {
          if (state is AuthAuthenticatedState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          }
          if (state is AuthFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text("Welcome ",
                            style: knormalTextStyle.copyWith(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.italic)),
                        Text("back!!",
                            style: knormalTextStyle.copyWith(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            )),
                      ],
                    ),
                  ),
                  Hero(
                    tag: 'logo',
                    child: Image.asset(
                      "assets/Images/logo.png",
                      height: screenWidth * 0.6,
                      width: screenWidth * 0.6,
                    ),
                  ),
                  // Email field
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Enter your email address",
                            style: knormalTextStyle.copyWith(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: TextField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                hintText: "Enter email here",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Password field
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Enter your Password",
                            style: knormalTextStyle.copyWith(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: TextField(
                              controller: passwordController,
                              decoration: const InputDecoration(
                                hintText: "Enter password here",
                                border: InputBorder.none,
                              ),
                              obscureText: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Login button
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35.0),
                      child: GestureDetector(
                        onTap: () {
                          context.read<AuthBlocBloc>().add(LoginRequested(
                                email: emailController.text,
                                password: passwordController.text,
                              ));
                        },
                        child: Container(
                          height: 56,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: kblue,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Center(
                            child: state is AuthLoadingState &&
                                    state.action == AuthAction.login
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    "Login",
                                    style: knormalTextStyle.copyWith(
                                        color: kwhite,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Switch to signup
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?",
                          style: knormalTextStyle.copyWith()),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupPage()));
                        },
                        child: Text(
                          "Click here",
                          style: knormalTextStyle.copyWith(
                            fontSize: 14,
                            color: Colors.blue,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
