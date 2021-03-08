import 'dart:io';
import 'package:dio/dio.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizz_app_using_riverpod/enum/difficulty.dart';
import 'package:quizz_app_using_riverpod/models/failure_models.dart';
import 'package:quizz_app_using_riverpod/models/question_models.dart';
import 'package:quizz_app_using_riverpod/repository/quizz/base_quizz_repository.dart';

final dioProvider = Provider<Dio>((ref) => Dio());

final quizRepositoryProvider =
    Provider<QuizRepository>((ref) => QuizRepository(ref.read));

class QuizRepository extends BaseQuizRepository {
  final Reader _read;
  QuizRepository(this._read);

  @override
  Future<List<Question>> getQuestion(
      {@required int numQuestion,
      @required int CategoryId,
      @required Difficulty difficulty}) async {
    try {
      final queryParameters = {
        'type': 'multiple',
        'amount': numQuestion,
        'category': CategoryId,
      };

      if (difficulty != Difficulty.any) {
        queryParameters.addAll({
          'difficulty': EnumToString.convertToString(difficulty),
        });
      }

      final response = await _read(dioProvider).get(
        'https://opentdb.com/api.php?amount=10&type=multiple',
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200) {
        final data = Map<String, dynamic>.from(response.data);
        final results = List<Map<String, dynamic>>.from(data['results'] ?? []);
        if (results.isNotEmpty) {
          return results.map((e) => Question.fromMap(e)).toList();
        }
      }
      return [];
    } on DioError catch (err) {
      print(err);
      throw Failure(message: err.response?.statusMessage);
    } on SocketException catch (err) {
      print(err);
      throw const Failure(message: 'Please check your connection');
    }
  }
}
