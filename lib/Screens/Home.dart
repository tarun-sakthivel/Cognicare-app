import 'package:cognicare/Bloc/reportGen/bloc/report_gen_bloc.dart';
import 'package:cognicare/Screens/Flow_exp.dart';
import 'package:cognicare/Screens/Report.dart';
import 'package:cognicare/Screens/ReportList.dart';
import 'package:cognicare/utils/local_storage.dart' show LocalStorage;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/AuthBloc/bloc/auth_bloc_bloc.dart';
import '../Widgets/reportWidget.dart';
import '../constants/Colors.dart';
import '../constants/text.dart';
import 'starter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return BlocListener<AuthBlocBloc, AuthBlocState>(
      listener: (context, state) {
        // if (state is AuthLoadingState) {
        //   // Show loading dialog
        //   showDialog(
        //     context: context,
        //     barrierDismissible: false,
        //     builder: (context) =>
        //         const Center(child: CircularProgressIndicator()),
        //   );
        // } else {
        //   // Always close loader if any state other than loading
        //   if (Navigator.canPop(context)) {
        //     Navigator.of(context, rootNavigator: true).pop();
        //   }
        // }

        if (state is AuthUnauthenticatedState) {
          // Now safely navigate after closing the loader
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Starter()),
            (Route<dynamic> route) => false,
          );
        } else if (state is AuthFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Logout failed. Try again!')),
          );
        }
      },
      child: Scaffold(
        backgroundColor: kwhite,
        appBar: AppBar(
          backgroundColor: kwhite,
          title: Image.asset(
            'assets/Images/CogniCare_text.png',
            height: 40,
          ),
          leading: Hero(
              transitionOnUserGestures: true,
              tag: 'logo',
              child: Image.asset(
                'assets/Images/logo1.png',
                height: 20,
                width: 20,
              )),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.notifications,
                color: Colors.black,
              ),
              onPressed: () {
                // Handle notification icon press
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ),
              onPressed: () {
                context.read<AuthBlocBloc>().add(LogoutRequested());
                //Navigator.pop(context);
                // Handle notification icon press
              },
            ),
            // IconButton(
            //     onPressed: () async {
            //       String? token = await LocalStorage.getToken();
            //       print("Home Page Token length: ${token?.length}");
            //       print("Home Page Token: $token");
            //     },
            //     icon: Icon(Icons.info)),
          ],
        ),
        body: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "\"Together, we unlock your child's amazing potential.\"",
                  textAlign: TextAlign.center,
                  style: knormalTextStyle.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: const Color.fromARGB(255, 79, 79, 79)),
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    context.read<ReportGenBloc>().add(ReportGenStart());
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ReportList()));
                  },
                  child: Stack(
                    children: [
                      Image.asset('assets/Images/Diagnose_button.png'),
                      Positioned(
                        left: 20,
                        bottom: 15,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.black,
                          child: const Icon(
                            Icons.arrow_outward,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Positioned(
                        left: 20,
                        top: 20,
                        child: Text(
                          "Reports",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Positioned(
                          right: 14,
                          top: 5,
                          child: Image.asset('assets/Images/report_icon.png',
                              height: 80)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FlowExp()),
                    );
                  },
                  child: Stack(
                    children: [
                      Image.asset('assets/Images/Diagnose_button.png'),
                      Positioned(
                        left: 20,
                        bottom: 15,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.black,
                          child: const Icon(
                            Icons.arrow_outward,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Positioned(
                        left: 20,
                        top: 20,
                        child: Text(
                          "Diagnose",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Positioned(
                          right: 18,
                          top: 5,
                          child: Image.asset('assets/Images/doc_icon.png',
                              height: 90)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Recently Added Reports',
                          style: knormalTextStyle.copyWith(
                              color: const Color.fromARGB(255, 98, 98, 98),
                              fontSize: 20,
                              fontWeight: FontWeight.w500)),
                      IconButton(
                          onPressed: () {
                            context.read<ReportGenBloc>().add(ReportGenStart());
                          },
                          icon: Icon(Icons.refresh))
                    ],
                  ),
                ),
                BlocBuilder<ReportGenBloc, ReportGenState>(
                    builder: (context, state) {
                  if (state is FetchLoading)
                    return Center(child: CircularProgressIndicator());
                  else if (state is FetchFailure)
                    return Center(child: Text("Failed to load reports"));
                  else if (state is FetchSuccess) {
                    final report = state.reports;
                    if (state.reports.isEmpty) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                            child: Text(
                              "No reports found",
                              style: knormalTextStyle.copyWith(
                                  color: Colors.grey, fontSize: 16),
                            ),
                          ),
                        ),
                      );
                    }
                    return ReportWidget(
                      name: "Report" + report[0].id.toString(),
                      date: report[0].timestamp.split('T').first,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ReportDetailPage(report: report[0])));
                        // Handle navigation to details or report page
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text("Opening report of Sabari Krishnan")),
                        );
                      },
                    );
                  }
                  // ignore: curly_braces_in_flow_control_structures
                  else
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            "No reports found",
                            style: knormalTextStyle.copyWith(
                                color: Colors.grey, fontSize: 16),
                          ),
                        ),
                      ),
                    );
                }),
              ],
            )),
      ),
    );
  }
}
