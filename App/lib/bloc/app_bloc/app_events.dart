import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AppEvent extends Equatable {
  const AppEvent([List props = const []]) : super();
}

class AppStarted extends AppEvent {
  @override
  String toString() => 'AppStarted';

  @override
  List<Object?> get props => [toString()];
}

class LoginUser extends AppEvent {
  final String email;
  final String password;

  const LoginUser({required this.email, required this.password});

  @override
  String toString() => 'LoginUser';

  @override
  List<Object?> get props => [toString()];
}

class LogoutUser extends AppEvent {
  @override
  String toString() => 'LogoutUser';

  @override
  List<Object?> get props => [toString()];
}