import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackmanthan_app/bloc/app_bloc/app_bloc_files.dart';
import 'package:hackmanthan_app/models/custom_exceptions.dart';
import 'package:hackmanthan_app/models/user.dart';
import 'package:hackmanthan_app/repositories/auth_repository.dart';
import 'package:hackmanthan_app/repositories/database_repository.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthRepository authRepository;
  late DatabaseRepository databaseRepository;
  late UserData user;

  AppBloc({required this.authRepository})
      : super(Uninitialized(user: UserData.empty)) {
    user = authRepository.getUserData;
    databaseRepository = DatabaseRepository(uid: user.uid);
    on<AppStarted>(_onAppStarted);
    on<LoginUser>(_onLoginUser);
    on<LogoutUser>(_onLogoutUser);
  }

  // When the App Starts
  FutureOr<void> _onAppStarted(AppStarted event, Emitter<AppState> emit) async {
    emit(Uninitialized(user: UserData.empty));
    try {
      user = authRepository.getUserData;
      if (user != UserData.empty) {
        // Authenticated
        // Update DatabaseRepository
        databaseRepository = DatabaseRepository(uid: user.uid);
        // Fetch rest of the user details from database
        UserData completeUserData = await databaseRepository.completeUserData;
        if (completeUserData != UserData.empty) {
          // if db fetch is successful
          user = completeUserData;
          emit(Authenticated(user: user));
        } else {
          // if db fetch fails
          emit(const ErrorOccurred(error: 'Failed to fetch details!'));
        }
      } else {
        emit(Unauthenticated(user: user));
      }
    } on Exception catch (e) {
      // If something goes wrong
      emit(ErrorOccurred(error: e.toString()));
    }
  }

  // When the App Starts
  FutureOr<void> _onLoginUser(LoginUser event, Emitter<AppState> emit) async {
    emit(LoginPageState.loading);
    try {
      // Login using email and password
      user = await authRepository.logInWithCredentials(
          event.email, event.password);
      // Update DatabaseRepository
      databaseRepository = DatabaseRepository(uid: user.uid);
      // After login fetch rest of the user details from database
      UserData completeUserData = await databaseRepository.completeUserData;
      if (completeUserData != UserData.empty) {
        // if db fetch is successful
        user = completeUserData;
        emit(Authenticated(user: user));
      } else {
        // if db fetch fails
        emit(const ErrorOccurred(error: 'Failed to fetch details!'));
      }
    } on Exception catch (e) {
      print(e);
      if (e is UserNotFoundException) {
        emit(LoginPageState.noUserFound);
      } else if (e is WrongPasswordException) {
        emit(LoginPageState.wrongPassword);
      } else {
        emit(LoginPageState.somethingWentWrong);
      }
    }
  }

  FutureOr<void> _onLogoutUser(LogoutUser event, Emitter<AppState> emit) async {
    emit(Uninitialized(user: user));
    user = UserData.empty;
    databaseRepository = DatabaseRepository(uid: '');
    await authRepository.signOut();
    emit(Unauthenticated(user: user));
  }
}
