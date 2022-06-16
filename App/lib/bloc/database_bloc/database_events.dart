import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DatabaseEvent extends Equatable {
  const DatabaseEvent([List props = const []]) : super();
}

class GetHomeContents extends DatabaseEvent {
  @override
  String toString() => 'GetHomeContents';

  @override
  List<Object?> get props => [toString()];
}

class StartLocationStream extends DatabaseEvent {
  @override
  String toString() => 'StartLocationStream';

  @override
  List<Object?> get props => [toString()];
}

class StopLocationStream extends DatabaseEvent {
  @override
  String toString() => 'StopLocationStream';

  @override
  List<Object?> get props => [toString()];
}

class GetCrimes extends DatabaseEvent {
  @override
  String toString() => 'GetHomeContents';

  @override
  List<Object?> get props => [toString()];
}

class GetPolice extends DatabaseEvent {
  @override
  String toString() => 'GetHomeContents';

  @override
  List<Object?> get props => [toString()];
}