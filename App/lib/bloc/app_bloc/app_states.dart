
import 'package:equatable/equatable.dart';
import 'package:hackmanthan_app/models/user.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AppState extends Equatable {
  const AppState([List props = const []]) : super();
}

class Uninitialized extends AppState {
  final UserData user;

  const Uninitialized({required this.user});

  @override
  String toString() => 'Uninitialized';

  @override
  List<Object?> get props => [toString()];
}

class Unauthenticated extends AppState {
  final UserData user;

  const Unauthenticated({required this.user});

  @override
  String toString() => 'Unauthenticated';

  @override
  List<Object?> get props => [toString()];
}

class Authenticated extends AppState {
  final UserData user;

  const Authenticated({required this.user});

  @override
  String toString() => 'Authenticated';

  @override
  List<Object?> get props => [toString()];
}

class ErrorOccurred extends AppState {
  final String error;

  const ErrorOccurred({required this.error});

  @override
  String toString() => 'ErrorOccurred';

  @override
  List<Object?> get props => [toString()];
}

class LoginPageState extends AppState {
  final String message;

  const LoginPageState({required this.message});

  static LoginPageState loading =
      const LoginPageState(message: 'Loading');

  static LoginPageState success =
      const LoginPageState(message: 'Successful');

  static LoginPageState noUserFound =
      const LoginPageState(message: 'No user found for that email');

  static LoginPageState wrongPassword = const LoginPageState(
      message: 'Wrong Password provided for that user');

  static LoginPageState somethingWentWrong = const LoginPageState(
      message: 'Something went wrong, Please try again');

  @override
  List<Object?> get props => [message];
}