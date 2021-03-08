import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Failure extends Equatable {
  final String message;

  const Failure({this.message = ''});

  @override
  List<Object> get props => [message];
}
