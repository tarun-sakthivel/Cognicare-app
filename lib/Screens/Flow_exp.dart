import 'package:cognicare/Bloc/Ques/questions_bloc.dart';
import 'package:cognicare/Screens/QuestionsPage.dart';
import 'package:cognicare/constants/Colors.dart';
import 'package:cognicare/constants/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlowExp extends StatefulWidget {
  const FlowExp({super.key});

  @override
  State<FlowExp> createState() => _FlowExpState();
}

class _FlowExpState extends State<FlowExp> {
  @override
  void initState() {
    super.initState();
    // Lock to portrait for this screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    // Restore all orientations when leaving the screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuestionsBloc, QuestionsState>(
      listener: (context, state) {
        // Handle messages or UI responses
        if (state is QuestionsInProgress) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => QuesPage()));
        }
      },
      child: Scaffold(
        backgroundColor: kwhite,
        appBar: AppBar(
          title: Text(
            "Introduction to diagnosis",
            style: knormalTextStyle.copyWith(
                fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
          child: Stack(
            children: [
              Align(
                alignment: Alignment(0, -0.7),
                child: Image.asset('assets/Images/street illustration.png'),
              ),
              Align(
                alignment: Alignment(-1, -1),
                child: Image.asset('assets/Images/Group 148.png'),
              ),
              Align(
                alignment: Alignment(1, -0.9),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "1. Questionary Section",
                      style: knormalTextStyle.copyWith(fontSize: 16),
                    ),
                    Text(
                      "In this section you will\n be answering for\n the questions asked.",
                      style: knormalTextStyle.copyWith(fontSize: 12),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment(1, -.23),
                child: Image.asset('assets/Images/bby_icon.png'),
              ),
              Align(
                alignment: Alignment(-0.8, -.23),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "2. Eye Tracking",
                      style: knormalTextStyle.copyWith(fontSize: 16),
                    ),
                    Text(
                      "  Video to be selected of\n user’s choice. \n Play the video to the child.",
                      style: knormalTextStyle.copyWith(fontSize: 12),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment(-0.8, .6),
                child: Image.asset('assets/Images/report vector.png'),
              ),
              Align(
                alignment: Alignment(0.8, .6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "3. Report and Analysis",
                      style: knormalTextStyle.copyWith(fontSize: 16),
                    ),
                    Text(
                      " A report will generated\n after few mins for \nparents and doctors \nreference.",
                      style: knormalTextStyle.copyWith(fontSize: 12),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    context.read<QuestionsBloc>().add(StartQuestionsEvent());
                  },
                  child: Container(
                    height: 55,
                    width: 220,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(40), // pill shape
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Click to start",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 30),
                        Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(40),
                                bottomRight: Radius.circular(40)),
                          ),
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
