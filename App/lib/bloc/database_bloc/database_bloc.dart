import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackmanthan_app/bloc/database_bloc/database_bloc_files.dart';
import 'package:hackmanthan_app/models/helper_models.dart';
import 'package:hackmanthan_app/models/user.dart';
import 'package:hackmanthan_app/repositories/auth_repository.dart';
import 'package:hackmanthan_app/repositories/database_repository.dart';
import 'package:hackmanthan_app/repositories/location_repository.dart';
import 'package:location/location.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  final AuthRepository authRepository;
  late DatabaseRepository databaseRepository;
  late UserData user;

  DatabaseBloc({required this.authRepository}) : super(const Init()) {
    user = authRepository.getUserData;
    databaseRepository = DatabaseRepository(uid: user.uid);
    on<GetHomeContents>(_onGetHomeContents);
    on<StartLocationStream>(_onStartLocationStream);
    on<StopLocationStream>(_onStopLocationStream);
  }

  // When
  FutureOr<void> _onGetHomeContents(
      GetHomeContents event, Emitter<DatabaseState> emit) async {
    emit(const HomePageState(pageState: PageState.loading));
    try {
      // API call to get Map Data
      

    } on Exception catch (_) {
      // If something goes wrong
      emit(const HomePageState(pageState: PageState.success));
    }
  }

  // When
  FutureOr<void> _onStartLocationStream(
      StartLocationStream event, Emitter<DatabaseState> emit) async {
    try {
      // 
      LocationData? locationData = await getLocation();

    } on Exception catch (_) {
      // If something goes wrong
    }
  }

  // When
  FutureOr<void> _onStopLocationStream(
      StopLocationStream event, Emitter<DatabaseState> emit) async {
    try {
      //
    } on Exception catch (e) {
      // If something goes wrong
    }
  }
}
