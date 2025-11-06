part of 'questions_bloc.dart';

abstract class QuestionsState extends Equatable {
  const QuestionsState();

  @override
  List<Object?> get props => [];
}

// Initial
class QuestionsInitial extends QuestionsState {}

// While answering
class QuestionsInProgress extends QuestionsState {
  final List<QuestionAnswer> answers;
  final int currentQuestion;

  const QuestionsInProgress({
    required this.answers,
    required this.currentQuestion,
  });

  @override
  List<Object?> get props => [answers, currentQuestion];
}

// After submitting
class QuestionsSubmitted extends QuestionsState {
  final List<QuestionAnswer> answers;

  const QuestionsSubmitted({required this.answers});

  @override
  List<Object?> get props => [answers];
}

class QuestionsExitState extends QuestionsState {
  const QuestionsExitState();
}
