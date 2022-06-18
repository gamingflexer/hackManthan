import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MapEvent extends Equatable {
  const MapEvent([List props = const []]) : super();
}

class GetHomeContents extends MapEvent {
  @override
  String toString() => 'GetHomeContents';

  @override
  List<Object?> get props => [toString()];
}

class StartLocationStream extends MapEvent {
  @override
  String toString() => 'StartLocationStream';

  @override
  List<Object?> get props => [toString()];
}

class StopLocationStream extends MapEvent {
  @override
  String toString() => 'StopLocationStream';

  @override
  List<Object?> get props => [toString()];
}

class ShowPredictions extends MapEvent {
  @override
  String toString() => 'ShowPredictions';

  @override
  List<Object?> get props => [toString()];
}

class HidePredictions extends MapEvent {
  @override
  String toString() => 'HidePredictions';

  @override
  List<Object?> get props => [toString()];
}

class ShowCrimes extends MapEvent {
  @override
  String toString() => 'ShowCrimes';

  @override
  List<Object?> get props => [toString()];
}

class HideCrime extends MapEvent {
  @override
  String toString() => 'HideCrime';

  @override
  List<Object?> get props => [toString()];
}

class ShowOfficers extends MapEvent {
  @override
  String toString() => 'ShowOfficers';

  @override
  List<Object?> get props => [toString()];
}

class HideOfficers extends MapEvent {
  @override
  String toString() => 'HideOfficers';

  @override
  List<Object?> get props => [toString()];
}

class FocusCrime extends MapEvent {
  @override
  String toString() => 'FocusCrime';

  @override
  List<Object?> get props => [toString()];
}

class UnfocusCrime extends MapEvent {
  @override
  String toString() => 'UnfocusCrime';

  @override
  List<Object?> get props => [toString()];
}
