import 'package:quizz_app_using_riverpod/enum/difficulty.dart';
import 'package:quizz_app_using_riverpod/models/question_models.dart';

abstract class BaseQuizRepository {
  Future<List<Question>> getQuestion({
    int numQuestion,
    int CategoryId,
    Difficulty difficulty,
  });
}
