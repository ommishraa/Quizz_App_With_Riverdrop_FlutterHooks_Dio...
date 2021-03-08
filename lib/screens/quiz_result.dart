import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizz_app_using_riverpod/controllert/quizz/quizz_controller.dart';
import 'package:quizz_app_using_riverpod/controllert/quizz/quizz_state.dart';
import 'package:quizz_app_using_riverpod/models/question_models.dart';
import 'package:quizz_app_using_riverpod/repository/quizz/quizz_repository.dart';

import 'custom_button.dart';

class QuizResults extends StatelessWidget {
  final QuizState state;
  final List<Question> questions;

  const QuizResults({
    Key key,
    @required this.state,
    @required this.questions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '${state.correct.length} / ${questions.length}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 60.0,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        const Text(
          'CORRECT',
          style: TextStyle(
            color: Colors.white,
            fontSize: 48.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40.0),
        CustomButton(
          title: 'New Quiz',
          onTap: () {
            context.refresh(quizRepositoryProvider);
            context.read(quizControllerProvider).reset();
          },
        ),
      ],
    );
  }
}
