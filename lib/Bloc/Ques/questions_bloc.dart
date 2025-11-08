import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cognicare/repositories/questions_repository.dart';
import 'package:cognicare/utils/local_storage.dart';
import 'package:cognicare/utils/shared_answers.dart';
import 'package:equatable/equatable.dart';
import '../../utils/question_model.dart';
part 'questions_event.dart';
part 'questions_state.dart';

class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  final QuestionsRepository questionsRepository = QuestionsRepository();
  QuestionsBloc() : super(QuestionsInitial()) {
    on<StartQuestionsEvent>((event, emit) {
      emit(QuestionsInProgress(
        currentQuestion: 1,
        answers: [],
      ));
    });
    on<SaveAnswerEvent>(_onSaveAnswer);
    on<GoToNextQuestionEvent>(_onGoToNextQuestion);
    on<SubmitAllAnswersEvent>(_onSubmitAllAnswers);
    on<QuestionsExitEvent>(
      (event, emit) {
        emit(QuestionsExitState());
        
      },
    );
  }

  void _onSaveAnswer(SaveAnswerEvent event, Emitter<QuestionsState> emit) {
    if (state is QuestionsInProgress) {
      final currentState = state as QuestionsInProgress;
      final updatedAnswers = List<QuestionAnswer>.from(currentState.answers);

      // Replace existing answer for same question, else add new
      final index = updatedAnswers
          .indexWhere((a) => a.questionNo == event.answer.questionNo);

      if (index >= 0) {
        updatedAnswers[index] = event.answer;
      } else {
        updatedAnswers.add(event.answer);
      }

      emit(QuestionsInProgress(
        answers: updatedAnswers,
        currentQuestion: currentState.currentQuestion,
      ));
    } else {
      emit(QuestionsInProgress(
        answers: [event.answer],
        currentQuestion: event.answer.questionNo,
      ));
    }
  }

  void _onGoToNextQuestion(
      GoToNextQuestionEvent event, Emitter<QuestionsState> emit) {
    if (state is QuestionsInProgress) {
      final currentState = state as QuestionsInProgress;
      emit(QuestionsInProgress(
        answers: currentState.answers,
        currentQuestion: event.nextQuestionNo,
      ));
    }
  }

  void _onSubmitAllAnswers(
      SubmitAllAnswersEvent event, Emitter<QuestionsState> emit) async {
    if (state is QuestionsInProgress) {
      final currentState = state as QuestionsInProgress;

      // Debug prints
      for (var ans in currentState.answers) {
        print("Q${ans.questionNo}: ${ans.answer}");
      }

      final Map<String, dynamic> data = {
        for (var ans in currentState.answers)
          'A${ans.questionNo - 5}': ans.answer,
        'Age_Mons': event.ageMons ?? 0,
        'Sex': event.sex ?? '',
        'Ethnicity': event.ethnicity ?? '',
        'Jaundice': event.jaundice ?? '',
        'Family_mem_with_ASD': event.familyMemWithASD ?? '',
      };
      print(
          "%%%%%%%%%%%%%%%%%%%%%%% Data formatted &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
      final body = data.map((key, value) => MapEntry(key, value.toString()));

      SharedAnswers.answers = body;
      //questionsRepository.submitForm(body);
      print(
          "%%%%%%%%%%%%%%%%%%%%%%% Data Saved Locally &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");

      await LocalStorage.setString('form_answers', jsonEncode(data));
      emit(QuestionsSubmitted(answers: currentState.answers));
    }
  }
}
// void _onSubmitAllAnswers(
//     SubmitAllAnswersEvent event, Emitter<QuestionsState> emit) async {
//   if (state is QuestionsInProgress) {
//     final currentState = state as QuestionsInProgress;
//     final answersMap = {
//       for (var ans in currentState.answers) 'A${ans.questionNo}': ans.answer,
//     };

//     // Add additional required fields if you collect them elsewhere
//     answersMap['Age_Mons'] = '0';
//     answersMap['Sex'] = 'm';
//     answersMap['Ethnicity'] = 'asian';
//     answersMap['Jaundice'] = 'no';
//     answersMap['Family_mem_with_ASD'] = 'no';

//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('form_answers', jsonEncode(answersMap));

//     emit(QuestionsSubmitted(answers: currentState.answers));
//   }
// }
