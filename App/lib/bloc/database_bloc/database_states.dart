import 'package:equatable/equatable.dart';
import 'package:hackmanthan_app/models/helper_models.dart';
import 'package:hackmanthan_app/models/user.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DatabaseState extends Equatable {
  const DatabaseState([List props = const []]) : super();
}

class Init extends DatabaseState {
  const Init();

  @override
  String toString() => '';

  @override
  List<Object?> get props => [toString()];
}

class HomePageState extends DatabaseState {
  final bool locationStreaming;
  final PageState pageState;

  const HomePageState({
    this.locationStreaming = false,
    this.pageState = PageState.init,
  });

  @override
  String toString() => '';

  @override
  List<Object?> get props => [toString()];
}
