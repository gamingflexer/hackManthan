import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackmanthan_app/bloc/map_bloc/map_bloc_files.dart';
import 'package:hackmanthan_app/models/alert.dart';
import 'package:hackmanthan_app/models/crime.dart';
import 'package:hackmanthan_app/models/helper_models.dart';
import 'package:hackmanthan_app/models/user.dart';
import 'package:hackmanthan_app/repositories/database_repository.dart';
import 'package:hackmanthan_app/repositories/location_repository.dart';
import 'package:location/location.dart';

class MapBloc extends Bloc<MapEvents, MapState> {
  DatabaseRepository databaseRepository;
  UserData user;

  MapBloc({required this.user, required this.databaseRepository})
      : super(const MapState.init()) {
    on<GetHomeContents>(_onGetHomeContents);
    on<StartLocationStream>(_onStartLocationStream);
    on<StopLocationStream>(_onStopLocationStream);
    on<ShowAlerts>(_onShowAlert);
    on<HideAlerts>(_onHideAlert);
    on<ShowCrimes>(_onShowCrimes);
    on<HideCrime>(_onHideCrime);
    on<ShowOfficers>(_onShowOfficers);
    on<HideOfficers>(_onHideOfficers);
    on<FocusCrime>(_onFocusCrime);
    on<UnfocusCrime>(_onUnfocusCrime);
    on<FocusOnCurrent>(_onFocusOnCurrent);
    // on<>(_on);
  }

  void updateCurrentLocation(Emitter<MapState> emit) async {}

  // When
  FutureOr<void> _onGetHomeContents(
      GetHomeContents event, Emitter<MapState> emit) async {
    emit(state.copyWith(pageState: PageState.loading));
    try {
      // API call to get Map Data
      await Future.delayed(const Duration(seconds: 1));
      LocationData? locationData = await LocationRepository.getLocation();
      if (locationData != null) {
        emit(state.copyWith(
          currentLat: locationData.latitude,
          currentLong: locationData.longitude,
          showCrimes: true,
          showAlerts: true,
          showOfficers: true,
          pageState: PageState.success,
        ));
        emit.forEach<List<Crime>>(
          databaseRepository.getCrimeStream(),
          onData: (data) {
            return state.copyWith(
              crimes: data,
            );
          },
        );
        // emit.forEach<List<UserData>>(
        //   databaseRepository.getUserStream(),
        //   onData: (data) {
        //     data.removeWhere((element) => element.uid == user.uid);
        //     return state.copyWith(
        //       officers: data,
        //     );
        //   },
        // );
        emit.forEach<List<Alert>>(
          databaseRepository.getAlertStream(),
          onData: (data) {
            return state.copyWith(
              alerts: data,
            );
          },
        );
        while (true) {
          LocationData? locationData = await LocationRepository.getLocation();
          if (locationData != null) {
            await Future.delayed(const Duration(seconds: 5))
                .whenComplete(() => emit(state.copyWith(
                      currentLat: locationData.latitude,
                      currentLong: locationData.longitude,
                    )));
          }
        }
      }
    } on Exception catch (_) {
      // If something goes wrong
      emit(state.copyWith(pageState: PageState.error));
    }
  }

  // When
  FutureOr<void> _onStartLocationStream(
      StartLocationStream event, Emitter<MapState> emit) async {
    try {
      emit(state.copyWith(locationStreaming: true));
      while (state.locationStreaming) {
        print('hi');
        LocationData? locationData = await LocationRepository.getLocation();
        if (locationData != null) {
          UserData newUser = user.copyWith(
            lat: locationData.latitude,
            long: locationData.longitude,
            lastUpdated: Timestamp.now(),
          );
          await databaseRepository.updateUser(newUser);
          print('updated ${newUser.lat}');
          await Future.delayed(const Duration(seconds: 10));
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
  FutureOr<void> _onShowAlert(ShowAlerts event, Emitter<MapState> emit) async {
    try {
      emit(state.copyWith(locationStreaming: false));
    } on Exception catch (_) {
      // If something goes wrong
    }
  }

  // When
  FutureOr<void> _onHideAlert(HideAlerts event, Emitter<MapState> emit) async {
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

  // When
  FutureOr<void> _onFocusOnCurrent(
      FocusOnCurrent event, Emitter<MapState> emit) async {
    try {
      emit(state.copyWith(locationStreaming: false));
    } on Exception catch (_) {
      // If something goes wrong
    }
  }
}
