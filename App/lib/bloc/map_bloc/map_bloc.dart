import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackmanthan_app/bloc/map_bloc/map_bloc_files.dart';
import 'package:hackmanthan_app/models/helper_models.dart';
import 'package:hackmanthan_app/models/user.dart';
import 'package:hackmanthan_app/repositories/database_repository.dart';
import 'package:hackmanthan_app/repositories/location_repository.dart';
import 'package:location/location.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  DatabaseRepository databaseRepository;
  UserData user;

  MapBloc({required this.user, required this.databaseRepository})
      : super(const MapState.init()) {
    on<GetHomeContents>(_onGetHomeContents);
    on<StartLocationStream>(_onStartLocationStream);
    on<StopLocationStream>(_onStopLocationStream);
    on<ShowPredictions>(_onShowPredictions);
    on<HidePredictions>(_onHidePredictions);
    on<ShowCrimes>(_onShowCrimes);
    on<HideCrime>(_onHideCrime);
    on<ShowOfficers>(_onShowOfficers);
    on<HideOfficers>(_onHideOfficers);
    on<FocusCrime>(_onFocusCrime);
    on<UnfocusCrime>(_onUnfocusCrime);
    // on<>(_on);
  }

  // When
  FutureOr<void> _onGetHomeContents(
      GetHomeContents event, Emitter<MapState> emit) async {
    emit(state.copyWith(pageState: PageState.loading));
    try {
      // API call to get Map Data
      
    } on Exception catch (_) {
      // If something goes wrong
      emit(state.copyWith(pageState: PageState.success));
    }
  }

  // When
  FutureOr<void> _onStartLocationStream(
      StartLocationStream event, Emitter<MapState> emit) async {
    try {
      emit(state.copyWith(locationStreaming: true));
      if (state.locationStreaming) {
        LocationData? locationData = await LocationRepository.getLocation();
        if (locationData != null) {
          UserData newUser = user.copyWith(
            lat: locationData.latitude,
            long: locationData.longitude,
          );
          await databaseRepository.updateUser(newUser);
        }
      }
    } on Exception catch (_) {
      // If something goes wrong
    }
  }

  // When
  FutureOr<void> _onStopLocationStream(
      StopLocationStream event, Emitter<MapState> emit) async {
    try {
      emit(state.copyWith(locationStreaming: false));
    } on Exception catch (_) {
      // If something goes wrong
    }
  }

  // When
  FutureOr<void> _onShowPredictions(
      ShowPredictions event, Emitter<MapState> emit) async {
    try {
      emit(state.copyWith(locationStreaming: false));
    } on Exception catch (_) {
      // If something goes wrong
    }
  }

  // When
  FutureOr<void> _onHidePredictions(
      HidePredictions event, Emitter<MapState> emit) async {
    try {
      emit(state.copyWith(locationStreaming: false));
    } on Exception catch (_) {
      // If something goes wrong
    }
  }

  // When
  FutureOr<void> _onShowCrimes(ShowCrimes event, Emitter<MapState> emit) async {
    try {
      emit(state.copyWith(locationStreaming: false));
    } on Exception catch (_) {
      // If something goes wrong
    }
  }

  // When
  FutureOr<void> _onHideCrime(HideCrime event, Emitter<MapState> emit) async {
    try {
      emit(state.copyWith(locationStreaming: false));
    } on Exception catch (_) {
      // If something goes wrong
    }
  }

  // When
  FutureOr<void> _onShowOfficers(
      ShowOfficers event, Emitter<MapState> emit) async {
    try {
      emit(state.copyWith(locationStreaming: false));
    } on Exception catch (_) {
      // If something goes wrong
    }
  }

  // When
  FutureOr<void> _onHideOfficers(
      HideOfficers event, Emitter<MapState> emit) async {
    try {
      emit(state.copyWith(locationStreaming: false));
    } on Exception catch (_) {
      // If something goes wrong
    }
  }

  // When
  FutureOr<void> _onFocusCrime(FocusCrime event, Emitter<MapState> emit) async {
    try {
      emit(state.copyWith(locationStreaming: false));
    } on Exception catch (_) {
      // If something goes wrong
    }
  }

  // When
  FutureOr<void> _onUnfocusCrime(
      UnfocusCrime event, Emitter<MapState> emit) async {
    try {
      emit(state.copyWith(locationStreaming: false));
    } on Exception catch (_) {
      // If something goes wrong
    }
  }
}
