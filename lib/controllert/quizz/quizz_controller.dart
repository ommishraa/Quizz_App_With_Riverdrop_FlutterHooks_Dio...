import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizz_app_using_riverpod/controllert/quizz/quizz_state.dart';
import 'package:quizz_app_using_riverpod/enum/quiz_status.dart';
import 'package:quizz_app_using_riverpod/models/question_models.dart';

final QuizControllerProvider =
    StateNotifierProvider.autoDispose<QuizController>(
  (ref) => QuizController(),
);

class QuizController extends StateNotifier<QuizState> {
  QuizController() : super(QuizState.initial());
  void submitAnswer(Question currentQuestion, String answer) {
    if (state.answered) return;
    if (currentQuestion.correctAnswer == answer) {
      state = state.copyWith(
        selectedAnswer: answer,
        correct: state.correct..add(currentQuestion),
        status: QuizStatus.correct,
      );
    } else {
      state = state.copyWith(
        selectedAnswer: answer,
        incorrect: state.incorrect..add(currentQuestion),
        status: QuizStatus.incorrect,
      );
    }
  }

  void nextQuestion(List<Question> question, int currentIndex) {
    state = state.copyWith(
      selectedAnswer: '',
      status: currentIndex + 1 < question.length
          ? QuizStatus.initial
          : QuizStatus.complete,
    );
  }

  void reset() {
    state = QuizState.initial();
  }
}
