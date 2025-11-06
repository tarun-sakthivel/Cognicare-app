class QuestionAnswer {
  final int questionNo;
  final String questionText;
  final String answer;
  final int questionType; 

  QuestionAnswer({
    required this.questionNo,
    required this.questionText,
    required this.answer,
    required this.questionType,
  });

  QuestionAnswer copyWith({
    int? questionNo,
    String? questionText,
    String? answer,
    int? questionType,
  }){
    return QuestionAnswer(
      questionNo: questionNo ?? this.questionNo,
      questionText: questionText ?? this.questionText,
      answer: answer ?? this.answer,
      questionType: questionType ?? this.questionType,
    );
  }
}