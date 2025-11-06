part of 'questions_bloc.dart';

abstract class QuestionsEvent extends Equatable {
  const QuestionsEvent();

  @override
  List<Object?> get props => [];
}

// Save an answer (text or yes/no)
class SaveAnswerEvent extends QuestionsEvent {
  final QuestionAnswer answer;
  const SaveAnswerEvent(this.answer);

  @override
  List<Object?> get props => [answer];
}

// Move to next question
class GoToNextQuestionEvent extends QuestionsEvent {
  final int nextQuestionNo;
  const GoToNextQuestionEvent(this.nextQuestionNo);

  @override
  List<Object?> get props => [nextQuestionNo];
}

// Submit all answers (to DB)
class SubmitAllAnswersEvent extends QuestionsEvent {
  final int? ageMons;
  final String? sex;
  final String? ethnicity;
  final String? jaundice;
  final String? familyMemWithASD;

  const SubmitAllAnswersEvent({
    this.ageMons,
    this.sex,
    this.ethnicity,
    this.jaundice,
    this.familyMemWithASD,
  });

  @override
  List<Object?> get props =>
      [ageMons, sex, ethnicity, jaundice, familyMemWithASD];
}

class StartQuestionsEvent extends QuestionsEvent {
  const StartQuestionsEvent();
}

class QuestionsExitEvent extends QuestionsEvent {
  const QuestionsExitEvent();
}
