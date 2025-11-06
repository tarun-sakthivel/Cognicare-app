// import 'package:cognicare/Widgets/questionary.dart';
// import 'package:cognicare/constants/text.dart';
// import 'package:flutter/material.dart';

// class QuesPage extends StatefulWidget {
//   const QuesPage({super.key});

//   @override
//   State<QuesPage> createState() => _QuesPageState();
// }

// class _QuesPageState extends State<QuesPage> {
//   @override
//   Widget build(BuildContext context) {
//     int type = 0;

//     const Color gradientStart = Color(0xFF2563EB); // Blue
//     const Color gradientEnd = Color(0xFF1F2937); // Dark Gray

// // Gradient variable
//     const LinearGradient primaryGradient = LinearGradient(
//       colors: [gradientStart, gradientEnd],
//       begin: Alignment.topLeft,
//       end: Alignment.bottomRight,
//     );
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         title: Text(
//           "Questionary",
//           style: knormalTextStyle.copyWith(
//               color: Colors.white, fontWeight: FontWeight.w600, fontSize: 26),
//         ),
//         centerTitle: true,
//         backgroundColor: primaryGradient.colors[0],
//       ),
//       backgroundColor: primaryGradient.colors[0],
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Questionary_widget(
//               question: "What is the name of your child ?", no: 2, type: type),
//           type == 0
//               ? //0 - text input //1 - options
//               ElevatedButton(onPressed: () {}, child: Text("Next"))
//               : Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     CircleAvatar(
//                       radius: 36,
//                       backgroundColor: Colors.white,
//                       child: Image.asset(
//                         'assets/Images/thumbsup.png',
//                         height: 50,
//                       ),
//                     ),
//                     CircleAvatar(
//                       radius: 36,
//                       backgroundColor: Colors.white,
//                       child: Image.asset(
//                         'assets/Images/thumbsdown.png',
//                         height: 50,
//                       ),
//                     )
//                   ],
//                 ),
//         ],
//       ),
//     );
//   }
// }

import 'package:cognicare/Screens/Video_Selection.dart' show VideoSelection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cognicare/constants/text.dart';
import 'package:cognicare/Widgets/questionary.dart';
import '../Bloc/Ques/questions_bloc.dart';
import '../utils/question_model.dart';

class QuesPage extends StatefulWidget {
  const QuesPage({super.key});

  @override
  State<QuesPage> createState() => _QuesPageState();
}

class _QuesPageState extends State<QuesPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    initState() {
      super.initState();
      _controller.clear();
    }

    const Color gradientEnd = Color(0xFF2563EB);
    const Color gradientStart = Color(0xFF213763);
    // int currentNo = 1;
    final List<QuestionAnswer> dummyAnswers = [
      QuestionAnswer(
        questionNo: 1,
        questionText: "Age in months",
        answer: "24",
        questionType: 0,
      ),
      QuestionAnswer(
        questionNo: 2,
        questionText: "Sex",
        answer: "Male",
        questionType: 0,
      ),
      QuestionAnswer(
        questionNo: 3,
        questionText: "Ethnicity",
        answer: "Asian",
        questionType: 0,
      ),
      QuestionAnswer(
        questionNo: 4,
        questionText: "Jaundice at birth?",
        answer: "No",
        questionType: 0,
      ),
      QuestionAnswer(
        questionNo: 5,
        questionText: "Any family member with Autism Spectrum Disorder (ASD)?",
        answer: "Yes",
        questionType: 0,
      ),
      QuestionAnswer(
        questionNo: 6,
        questionText: "Does your child look at you when you call his/her name?",
        answer: "Yes",
        questionType: 1,
      ),
      QuestionAnswer(
        questionNo: 7,
        questionText:
            "How easy is it for you to get eye contact with your child?",
        answer: "No",
        questionType: 1,
      ),
      QuestionAnswer(
        questionNo: 8,
        questionText:
            "Does your child point to indicate that s/he wants something?",
        answer: "Yes",
        questionType: 1,
      ),
      QuestionAnswer(
        questionNo: 9,
        questionText: "Does your child point to share interest with you?",
        answer: "No",
        questionType: 1,
      ),
      QuestionAnswer(
        questionNo: 10,
        questionText: "Does your child pretend?",
        answer: "Yes",
        questionType: 1,
      ),
      QuestionAnswer(
        questionNo: 11,
        questionText: "Does your child follow where you're looking?",
        answer: "No",
        questionType: 1,
      ),
      QuestionAnswer(
        questionNo: 12,
        questionText:
            "If someone in the family is visibly upset, does your child show signs of wanting to comfort them?",
        answer: "Yes",
        questionType: 1,
      ),
      QuestionAnswer(
        questionNo: 13,
        questionText: "Would you describe your child's first words as clear?",
        answer: "Yes",
        questionType: 1,
      ),
      QuestionAnswer(
        questionNo: 14,
        questionText: "Does your child use simple gestures?",
        answer: "No",
        questionType: 1,
      ),
      QuestionAnswer(
        questionNo: 15,
        questionText:
            "Does your child stare at nothing with no apparent purpose?",
        answer: "Yes",
        questionType: 1,
      ),
      QuestionAnswer(
        questionNo: 16,
        questionText: "Thank you for completing the questionnaire!",
        answer: "",
        questionType: 2,
      ),
    ];

    // return BlocListener<QuestionsBloc, QuestionsState>(
    //   listener: (context, state) {
    //     // TODO: implement listener
    //     if (state is QuestionsSubmitted) {
    //       Navigator.pushReplacement(
    //         context,
    //         MaterialPageRoute(builder: (context) => const VideoSelection()),
    //       );
    //     }
    //   },
    //   child: BlocBuilder<QuestionsBloc, QuestionsState>(
    //     builder: (context, state) {
    //       const Color gradientEnd = Color(0xFF2563EB);
    //       const Color gradientStart = Color(0xFF213763);
    //       // int currentNo = 1;
    //       if (state is QuestionsInProgress) {
    //         // currentNo = state.currentQuestion;
    //         return Scaffold(
    //           resizeToAvoidBottomInset: true,
    //           appBar: AppBar(
    //             leading: IconButton(
    //               icon: const Icon(Icons.arrow_back, color: Colors.white),
    //               onPressed: () => Navigator.of(context).pop(),
    //             ),
    //             title: Text(
    //               "Questionary",
    //               style: knormalTextStyle.copyWith(
    //                 color: Colors.white,
    //                 fontWeight: FontWeight.w600,
    //                 fontSize: 26,
    //               ),
    //             ),
    //             centerTitle: true,
    //             backgroundColor: gradientStart,
    //           ),
    //           backgroundColor: gradientStart,
    //           body: Container(
    //             height: double.infinity,
    //             decoration: BoxDecoration(
    //               gradient: LinearGradient(
    //                 colors: [gradientStart, gradientEnd],
    //                 begin: Alignment.topCenter,
    //                 end: Alignment.bottomCenter,
    //               ),
    //             ),
    //             child: SingleChildScrollView(
    //               padding: EdgeInsets.only(
    //                 left: 16,
    //                 right: 16,
    //                 bottom: MediaQuery.of(context).viewInsets.bottom +
    //                     16, // pushes up when keyboard opens
    //               ),
    //               child: ConstrainedBox(
    //                 constraints: BoxConstraints(
    //                     minHeight: MediaQuery.of(context).size.height -
    //                         kToolbarHeight -
    //                         32), // 32 for padding
    //                 child: IntrinsicHeight(
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                     crossAxisAlignment: CrossAxisAlignment.center,
    //                     children: [
    //                       // Your custom widget
    //                       Questionary_widget(
    //                         question: dummyAnswers[state.currentQuestion - 1]
    //                             .questionText,
    //                         no: state.currentQuestion,
    //                         type: dummyAnswers[state.currentQuestion - 1]
    //                             .questionType, // just example
    //                         controller: _controller,
    //                       ),

    //                       // --- TEXT INPUT case ---
    //                       if (dummyAnswers[state.currentQuestion - 1]
    //                               .questionType ==
    //                           0)
    //                         ElevatedButton(
    //                           style: ElevatedButton.styleFrom(
    //                             minimumSize: Size(230, 50),
    //                             maximumSize: Size(260, 50),
    //                             backgroundColor: Colors.white,
    //                             foregroundColor: Colors.black,
    //                             shadowColor: Colors.black,
    //                             shape: RoundedRectangleBorder(
    //                               borderRadius: BorderRadius.circular(15),
    //                             ),
    //                           ),
    //                           onPressed: () {
    //                             final text = _controller.text;
    //                             if (text.isNotEmpty) {
    //                               context.read<QuestionsBloc>().add(
    //                                     SaveAnswerEvent(
    //                                       QuestionAnswer(
    //                                         questionNo: state.currentQuestion,
    //                                         questionText: dummyAnswers[
    //                                                 state.currentQuestion]
    //                                             .questionText,
    //                                         answer: text,
    //                                         questionType: dummyAnswers[
    //                                                 state.currentQuestion]
    //                                             .questionType,
    //                                       ),
    //                                     ),
    //                                   );

    //                               context.read<QuestionsBloc>().add(
    //                                   GoToNextQuestionEvent(
    //                                       state.currentQuestion + 1));
    //                               _controller.clear();
    //                             }
    //                           },
    //                           child: Text(
    //                             "Next",
    //                             style: knormalTextStyle.copyWith(fontSize: 20),
    //                           ),
    //                         )
    //                       else if (dummyAnswers[state.currentQuestion - 1]
    //                                   .questionType ==
    //                               2 &&
    //                           state.currentQuestion == 16)
    //                         GestureDetector(
    //                           onTap: () {
    //                             context
    //                                 .read<QuestionsBloc>()
    //                                 .add(SubmitAllAnswersEvent());
    //                           },
    //                           child: Container(
    //                             height: 55,
    //                             width: 220,
    //                             decoration: BoxDecoration(
    //                               color: Colors.white,
    //                               borderRadius:
    //                                   BorderRadius.circular(40), // pill shape
    //                               boxShadow: [
    //                                 BoxShadow(
    //                                   color: Colors.black.withOpacity(0.2),
    //                                   spreadRadius: 3,
    //                                   blurRadius: 5,
    //                                   offset: Offset(
    //                                       0, 3), // changes position of shadow
    //                                 ),
    //                               ],
    //                             ),
    //                             child: Row(
    //                               mainAxisAlignment: MainAxisAlignment.end,
    //                               children: [
    //                                 Center(
    //                                   child: Text(
    //                                     "Proceed to video",
    //                                     style: TextStyle(
    //                                       fontSize: 16,
    //                                       color: Colors.black,
    //                                     ),
    //                                   ),
    //                                 ),
    //                                 SizedBox(width: 10),
    //                                 Container(
    //                                   height: 55,
    //                                   width: 55,
    //                                   decoration: BoxDecoration(
    //                                     color: Colors.black,
    //                                     borderRadius: BorderRadius.only(
    //                                         topRight: Radius.circular(40),
    //                                         bottomRight: Radius.circular(40)),
    //                                   ),
    //                                   child: Icon(
    //                                     Icons.arrow_forward,
    //                                     color: Colors.white,
    //                                   ),
    //                                 )
    //                               ],
    //                             ),
    //                           ),
    //                         )
    //                       // --- YES / NO case ---
    //                       else
    //                         Row(
    //                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                           crossAxisAlignment: CrossAxisAlignment.center,
    //                           children: [
    //                             GestureDetector(
    //                               onTap: () {
    //                                 context.read<QuestionsBloc>().add(
    //                                       SaveAnswerEvent(
    //                                         QuestionAnswer(
    //                                             questionNo:
    //                                                 state.currentQuestion,
    //                                             questionText: dummyAnswers[
    //                                                     state.currentQuestion -
    //                                                         1]
    //                                                 .questionText,
    //                                             answer: "Yes",
    //                                             questionType: dummyAnswers[
    //                                                     state.currentQuestion -
    //                                                         1]
    //                                                 .questionType),
    //                                       ),
    //                                     );
    //                                 context.read<QuestionsBloc>().add(
    //                                     GoToNextQuestionEvent(
    //                                         state.currentQuestion + 1));
    //                               },
    //                               child: CircleAvatar(
    //                                 radius: 36,
    //                                 backgroundColor: Colors.white,
    //                                 child: Image.asset(
    //                                     'assets/Images/thumbsup.png',
    //                                     height: 50),
    //                               ),
    //                             ),
    //                             GestureDetector(
    //                               onTap: () {
    //                                 context.read<QuestionsBloc>().add(
    //                                       SaveAnswerEvent(
    //                                         QuestionAnswer(
    //                                             questionNo:
    //                                                 state.currentQuestion,
    //                                             questionText: dummyAnswers[
    //                                                     state.currentQuestion]
    //                                                 .questionText,
    //                                             answer: "No",
    //                                             questionType: dummyAnswers[
    //                                                     state.currentQuestion]
    //                                                 .questionType),
    //                                       ),
    //                                     );
    //                                 context.read<QuestionsBloc>().add(
    //                                     GoToNextQuestionEvent(
    //                                         state.currentQuestion + 1));
    //                               },
    //                               child: CircleAvatar(
    //                                 radius: 36,
    //                                 backgroundColor: Colors.white,
    //                                 child: Image.asset(
    //                                     'assets/Images/thumbsdown.png',
    //                                     height: 50),
    //                               ),
    //                             )
    //                           ],
    //                         ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ),
    //         );
    return BlocConsumer<QuestionsBloc, QuestionsState>(
      listener: (context, state) {
        if (state is QuestionsSubmitted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const VideoSelection()),
          );
        }
      },
      builder: (context, state) {
        if (state is! QuestionsInProgress) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }

        final currentQuestion = dummyAnswers[state.currentQuestion - 1];

        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                context.read<QuestionsBloc>().add(QuestionsExitEvent());
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              "Questionary",
              style: knormalTextStyle.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 26,
              ),
            ),
            centerTitle: true,
            backgroundColor: gradientStart,
          ),
          backgroundColor: gradientStart,
          body: Container(
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [gradientStart, gradientEnd],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      MediaQuery.of(context).size.height - kToolbarHeight - 32,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Questionary_widget(
                        question: currentQuestion.questionText,
                        no: currentQuestion.questionNo,
                        type: currentQuestion.questionType,
                        controller: _controller,
                      ),
                      const SizedBox(height: 20),
                      if (currentQuestion.questionType == 0)
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(230, 50),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () {
                            final text = _controller.text;
                            if (text.isNotEmpty) {
                              context.read<QuestionsBloc>().add(
                                    SaveAnswerEvent(
                                      QuestionAnswer(
                                        questionNo: currentQuestion.questionNo,
                                        questionText:
                                            currentQuestion.questionText,
                                        answer: text,
                                        questionType:
                                            currentQuestion.questionType,
                                      ),
                                    ),
                                  );
                              context.read<QuestionsBloc>().add(
                                  GoToNextQuestionEvent(
                                      state.currentQuestion + 1));
                              _controller.clear();
                            }
                          },
                          child: Text(
                            "Next",
                            style: knormalTextStyle.copyWith(fontSize: 20),
                          ),
                        )
                      else if (currentQuestion.questionType == 2 &&
                          state.currentQuestion == 16)
                        GestureDetector(
                          onTap: () {
                            context
                                .read<QuestionsBloc>()
                                .add(SubmitAllAnswersEvent());
                          },
                          child: Container(
                            height: 55,
                            width: 220,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(40), // pill shape
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Center(
                                  child: Text(
                                    "Proceed to video",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  height: 55,
                                  width: 55,
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(40),
                                      bottomRight: Radius.circular(40),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.read<QuestionsBloc>().add(
                                      SaveAnswerEvent(
                                        QuestionAnswer(
                                          questionNo:
                                              currentQuestion.questionNo,
                                          questionText:
                                              currentQuestion.questionText,
                                          answer: "1",
                                          questionType:
                                              currentQuestion.questionType,
                                        ),
                                      ),
                                    );
                                context.read<QuestionsBloc>().add(
                                    GoToNextQuestionEvent(
                                        state.currentQuestion + 1));
                              },
                              child: const CircleAvatar(
                                radius: 36,
                                backgroundColor: Colors.white,
                                child: Image(
                                  image:
                                      AssetImage('assets/Images/thumbsup.png'),
                                  height: 50,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.read<QuestionsBloc>().add(
                                      SaveAnswerEvent(
                                        QuestionAnswer(
                                          questionNo:
                                              currentQuestion.questionNo,
                                          questionText:
                                              currentQuestion.questionText,
                                          answer: "0",
                                          questionType:
                                              currentQuestion.questionType,
                                        ),
                                      ),
                                    );
                                context.read<QuestionsBloc>().add(
                                    GoToNextQuestionEvent(
                                        state.currentQuestion + 1));
                              },
                              child: const CircleAvatar(
                                radius: 36,
                                backgroundColor: Colors.white,
                                child: Image(
                                  image: AssetImage(
                                      'assets/Images/thumbsdown.png'),
                                  height: 50,
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
          // return Scaffold(
          //   appBar: AppBar(
          //     leading: IconButton(
          //       icon: const Icon(Icons.arrow_back, color: Colors.white),
          //       onPressed: () => Navigator.of(context).pop(),
          //     ),
          //     title: Text(
          //       "Questionary",
          //       style: knormalTextStyle.copyWith(
          //         color: Colors.white,
          //         fontWeight: FontWeight.w600,
          //         fontSize: 26,
          //       ),
          //     ),
          //     centerTitle: true,
          //     backgroundColor: gradientStart,
          //   ),
          //   backgroundColor: gradientStart,
          //   body: Column(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       // Your custom widget
          //       Questionary_widget(
          //         question: "${dummyAnswers[currentNo].questionText}",
          //         no: currentNo,
          //         type: currentNo == 1 ? 0 : 1, // just example
          //       ),

          //       // --- TEXT INPUT case ---
          //       if (currentNo == 1)
          //         ElevatedButton(
          //           onPressed: () {
          //             final text = _controller.text;
          //             if (text.isNotEmpty) {
          //               context.read<QuestionsBloc>().add(
          //                     SaveAnswerEvent(
          //                       QuestionAnswer(
          //                         questionNo: currentNo,
          //                         questionText:
          //                             "${dummyAnswers[currentNo].questionText}",
          //                         answer: text,
          //                       ),
          //                     ),
          //                   );

          //               context
          //                   .read<QuestionsBloc>()
          //                   .add(GoToNextQuestionEvent(currentNo + 1));
          //             }
          //           },
          //           child: const Text("Next"),
          //         )
          //       // --- YES / NO case ---
          //       else
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: [
          //             GestureDetector(
          //               onTap: () {
          //                 context.read<QuestionsBloc>().add(
          //                       SaveAnswerEvent(
          //                         QuestionAnswer(
          //                           questionNo: currentNo,
          //                           questionText:
          //                               "${dummyAnswers[currentNo].questionText}",
          //                           answer: "Yes",
          //                         ),
          //                       ),
          //                     );
          //                 context
          //                     .read<QuestionsBloc>()
          //                     .add(GoToNextQuestionEvent(currentNo + 1));
          //               },
          //               child: CircleAvatar(
          //                 radius: 36,
          //                 backgroundColor: Colors.white,
          //                 child: Image.asset('assets/Images/thumbsup.png',
          //                     height: 50),
          //               ),
          //             ),
          //             GestureDetector(
          //               onTap: () {
          //                 context.read<QuestionsBloc>().add(
          //                       SaveAnswerEvent(
          //                         QuestionAnswer(
          //                           questionNo: currentNo,
          //                           questionText:
          //                               "${dummyAnswers[currentNo].questionText}",
          //                           answer: "No",
          //                         ),
          //                       ),
          //                     );
          //                 context
          //                     .read<QuestionsBloc>()
          //                     .add(GoToNextQuestionEvent(currentNo + 1));
          //               },
          //               child: CircleAvatar(
          //                 radius: 36,
          //                 backgroundColor: Colors.white,
          //                 child: Image.asset('assets/Images/thumbsdown.png',
          //                     height: 50),
          //               ),
          //             )
          //           ],
          //         ),
          //     ],
          //   ),
          // );
