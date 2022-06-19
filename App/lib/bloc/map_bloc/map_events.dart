import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MapEvents extends Equatable {
  const MapEvents([List props = const []]) : super();
}

class GetHomeContents extends MapEvents {
  @override
  String toString() => 'GetHomeContents';

  @override
  List<Object?> get props => [toString()];
}

class StartLocationStream extends MapEvents {
  @override
  String toString() => 'StartLocationStream';

  @override
  List<Object?> get props => [toString()];
}

class StopLocationStream extends MapEvents {
  @override
  String toString() => 'StopLocationStream';

  @override
  List<Object?> get props => [toString()];
}

class ShowPredictions extends MapEvents {
  @override
  String toString() => 'ShowPredictions';

  @override
  List<Object?> get props => [toString()];
}

class HidePredictions extends MapEvents {
  @override
  String toString() => 'HidePredictions';

  @override
  List<Object?> get props => [toString()];
}

class ShowCrimes extends MapEvents {
  @override
  String toString() => 'ShowCrimes';

  @override
  List<Object?> get props => [toString()];
}

class HideCrime extends MapEvents {
  @override
  String toString() => 'HideCrime';

  @override
  List<Object?> get props => [toString()];
}

class ShowOfficers extends MapEvents {
  @override
  String toString() => 'ShowOfficers';

  @override
  List<Object?> get props => [toString()];
}

class HideOfficers extends MapEvents {
  @override
  String toString() => 'HideOfficers';

  @override
  List<Object?> get props => [toString()];
}

class FocusCrime extends MapEvents {
  @override
  String toString() => 'FocusCrime';

  @override
  List<Object?> get props => [toString()];
}

class UnfocusCrime extends MapEvents {
  @override
  String toString() => 'UnfocusCrime';

  @override
  List<Object?> get props => [toString()];
}

class FocusOnCurrent extends MapEvents {
  @override
  String toString() => 'FocusOnCurrent';

  @override
  List<Object?> get props => [toString()];
}
