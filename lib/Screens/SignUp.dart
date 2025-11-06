// import 'dart:math';

// import 'package:cognicare/Screens/SignIn.dart';
// import 'package:cognicare/constants/Colors.dart';
// import 'package:cognicare/constants/text.dart';
// import 'package:flutter/material.dart';

// import 'starter.dart';

// class SignUp extends StatefulWidget {
//   const SignUp({super.key});

//   @override
//   State<SignUp> createState() => _SignUpState();
// }

// class _SignUpState extends State<SignUp> {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController confirmPasswordController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     int screenWidth = MediaQuery.of(context).size.width.toInt();
//     return Scaffold(
//       drawerEnableOpenDragGesture: false,
//       backgroundColor: kwhite,
//       appBar: AppBar(
//         backgroundColor: kwhite,
//         title: Text(
//           "Sign Up",
//           style: knormalTextStyle.copyWith(
//               fontWeight: FontWeight.w500, fontSize: 24),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(builder: (context) => const Starter()),
//               (Route<dynamic> route) => false, // remove all previous routes
//             );
//           },
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   "Hello! Register to get started.",
//                   style: knormalTextStyle.copyWith(
//                       fontSize: 20, fontWeight: FontWeight.w500),
//                 ),
//               ),
//               Hero(
//                 tag: 'logo',
//                 child: Image.asset(
//                   "assets/Images/logo.png",
//                   height: screenWidth * 0.6,
//                   width: screenWidth * 0.6,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Enter your email address",
//                         style: knormalTextStyle.copyWith(
//                             fontSize: 14, fontWeight: FontWeight.w500)),
//                     Container(
//                       decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Colors.grey,
//                           ),
//                           borderRadius: BorderRadius.all(Radius.circular(15))),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                         child: TextField(
//                           controller: emailController,
//                           decoration: const InputDecoration(
//                             hintText: "Enter email here",
//                             border: InputBorder.none,
//                           ),
//                           obscureText: true,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 20.0, bottom: 20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Enter your Password",
//                         style: knormalTextStyle.copyWith(
//                             fontSize: 14, fontWeight: FontWeight.w500)),
//                     Container(
//                       decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Colors.grey,
//                           ),
//                           borderRadius: BorderRadius.all(Radius.circular(15))),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                         child: TextField(
//                           controller: passwordController,
//                           decoration: const InputDecoration(
//                             hintText: "Enter password here",
//                             border: InputBorder.none,
//                           ),
//                           obscureText: true,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Confirm your Password",
//                         style: knormalTextStyle.copyWith(
//                             fontSize: 14, fontWeight: FontWeight.w500)),
//                     Container(
//                       decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Colors.grey,
//                           ),
//                           borderRadius: BorderRadius.all(Radius.circular(15))),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                         child: TextField(
//                           controller: confirmPasswordController,
//                           decoration: const InputDecoration(
//                             hintText: "Enter password here",
//                             border: InputBorder.none,
//                           ),
//                           obscureText: true,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 35.0),
//                 child: GestureDetector(
//                   child: Container(
//                     height: 56,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: kblue,
//                       borderRadius: BorderRadius.all(Radius.circular(15)),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           spreadRadius: 2,
//                           blurRadius: 5,
//                           offset:
//                               const Offset(0, 3), // changes position of shadow
//                         ),
//                       ],
//                     ),
//                     child: Center(
//                       child: Text(
//                         "Register",
//                         style: knormalTextStyle.copyWith(
//                             color: kwhite,
//                             fontSize: 20,
//                             fontWeight: FontWeight.w500),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("Already have an account?",
//                       style: knormalTextStyle.copyWith()),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) => Signin()));
//                     },
//                     child: Text(
//                       "Click here",
//                       style: knormalTextStyle.copyWith(
//                         fontSize: 14,
//                         color: Colors.blue,
//                       ),
//                     ),
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Bloc/AuthBloc/bloc/auth_bloc_bloc.dart';
import '../constants/Colors.dart';
import '../constants/text.dart';
import 'SignIn.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
        title: const Text("Signup"),
        backgroundColor: kwhite,
      ),
      body: BlocConsumer<AuthBlocBloc, AuthBlocState>(
        listener: (context, state) {
          if (state is AuthAuthenticatedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Signup Success!")),
            );
            Navigator.pop(context); // Go back to Starter or Welcome
          } else if (state is AuthFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Greeting
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Hello! Register to get started.",
                      style: knormalTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  // Logo
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
                        Text(
                          "Enter your email address",
                          style: knormalTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                          ),
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
                        Text(
                          "Enter your Password",
                          style: knormalTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                          ),
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

                  // Confirm password field
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Confirm your Password",
                          style: knormalTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: TextField(
                              controller: confirmPasswordController,
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

                  // Register button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35.0),
                    child: GestureDetector(
                      onTap: () {
                        // TODO: Add register logic
                        if (confirmPasswordController.text !=
                            passwordController.text) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Passwords do not match!")),
                          );
                          return;
                        } else {
                          context.read<AuthBlocBloc>().add(
                                SignupRequested(
                                  email: emailController.text,
                                  password: passwordController.text,
                                ),
                              );
                        }
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
                          child: Text(
                            "Register",
                            style: knormalTextStyle.copyWith(
                              color: kwhite,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Login redirect
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: knormalTextStyle.copyWith(),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Signin()),
                          );
                        },
                        child: Text(
                          "Click here",
                          style: knormalTextStyle.copyWith(
                            fontSize: 14,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
