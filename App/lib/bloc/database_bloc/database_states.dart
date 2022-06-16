import 'package:equatable/equatable.dart';
import 'package:hackmanthan_app/models/helper_models.dart';
import 'package:hackmanthan_app/models/user.dart';
import 'package:meta/meta.dart';

@immutable
class DatabaseState extends Equatable {
  final bool locationStreaming;

  const DatabaseState({this.locationStreaming = false}) : super();

  DatabaseState copyWith({
    bool? locationStreaming,
  }) {
    return DatabaseState(
      locationStreaming: locationStreaming ?? this.locationStreaming,
    );
  }
  
  @override
  List<Object?> get props => [];
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

  HomePageState copyWith({
    bool? locationStreaming,
    PageState? pageState,
  }) {
    return HomePageState(
      locationStreaming: locationStreaming ?? this.locationStreaming,
      pageState: pageState ?? this.pageState,
    );
  }

  @override
  String toString() => '';

  @override
  List<Object?> get props => [toString()];
}
