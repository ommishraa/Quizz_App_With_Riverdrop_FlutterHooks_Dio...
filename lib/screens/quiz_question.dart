import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:html_character_entities/html_character_entities.dart';
import 'package:quizz_app_using_riverpod/controllert/quizz/quizz_controller.dart';
import 'package:quizz_app_using_riverpod/controllert/quizz/quizz_state.dart';
import 'package:quizz_app_using_riverpod/models/question_models.dart';

import 'answer_card.dart';

class QuizQuestions extends StatelessWidget {
  final PageController pageController;
  final QuizState state;
  final List<Question> questions;

  const QuizQuestions({
    Key key,
    @required this.pageController,
    @required this.state,
    @required this.questions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      physics: NeverScrollableScrollPhysics(),
      itemCount: questions.length,
      itemBuilder: (BuildContext context, int index) {
        final question = questions[index];
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Question ${index + 1} of ${questions.length}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 12.0),
              child: Text(
                HtmlCharacterEntities.decode(question.question),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Divider(
              color: Colors.grey[200],
              height: 32.0,
              thickness: 2.0,
              indent: 20.0,
              endIndent: 20.0,
            ),
            Column(
              children: question.answers
                  .map(
                    (e) => AnswerCard(
                      answer: e,
                      isSelected: e == state.selectedAnswer,
                      isCorrect: e == question.correctAnswer,
                      isDisplayingAnswer: state.answered,
                      onTap: () => context
                          .read(quizControllerProvider)
                          .submitAnswer(question, e),
                    ),
                  )
                  .toList(),
            ),
          ],
        );
      },
    );
  }
}
