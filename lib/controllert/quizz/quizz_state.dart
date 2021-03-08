import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:quizz_app_using_riverpod/enum/quiz_status.dart';
import 'package:quizz_app_using_riverpod/models/question_models.dart';

class QuizState extends Equatable {
  final String selectedAnswer;
  final List<Question> correct;
  final List<Question> incorrect;
  final QuizStatus status;

  bool get answered =>
      status == QuizStatus.incorrect || status == QuizStatus.correct;

  const QuizState(
      {@required this.selectedAnswer,
      @required this.correct,
      @required this.incorrect,
      @required this.status});

  factory QuizState.initial() {
    return QuizState(
        selectedAnswer: '',
        correct: [],
        incorrect: [],
        status: QuizStatus.initial);
  }

  @override
  // TODO: implement props
  List<Object> get props => [
        selectedAnswer,
        correct,
        incorrect,
        status,
      ];

  QuizState copyWith({
    String selectedAnswer,
    List<Question> correct,
    List<Question> incorrect,
    QuizStatus status,
  }) {
    return QuizState(
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
      correct: correct ?? this.correct,
      incorrect: incorrect ?? this.incorrect,
      status: status ?? this.status,
    );
  }
}
