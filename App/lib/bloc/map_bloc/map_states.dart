import 'package:equatable/equatable.dart';
import 'package:hackmanthan_app/models/crime.dart';
import 'package:hackmanthan_app/models/helper_models.dart';
import 'package:hackmanthan_app/models/prediction.dart';
import 'package:hackmanthan_app/models/user.dart';

class MapState extends Equatable {
  final bool locationStreaming;
  final bool showPredictions;
  final bool showCrimes;
  final bool showOfficers;
  // final bool focusOnACrime;
  final Crime? focusedCrime;
  final List<Prediction> predictions;
  final List<Crime> crimes;
  final List<UserData> officers;
  final double currentLat;
  final double currentLong;
  final PageState pageState;

  const MapState({
    required this.locationStreaming,
    required this.showPredictions,
    required this.showCrimes,
    required this.showOfficers,
    required this.focusedCrime,
    // required this.focusOnACrime,
    required this.predictions,
    required this.crimes,
    required this.officers,
    required this.currentLat,
    required this.currentLong,
    required this.pageState,
  });

  MapState copyWith({
    bool? locationStreaming,
    bool? showPredictions,
    bool? showCrimes,
    bool? showOfficers,
    // bool? focusOnACrime,
    Crime? focusedCrime,
    List<Prediction>? predictions,
    List<Crime>? crimes,
    List<UserData>? officers,
    double? currentLat,
    double? currentLong,
    PageState? pageState,
  }) {
    return MapState(
      locationStreaming: locationStreaming ?? this.locationStreaming,
      showPredictions: showPredictions ?? this.showPredictions,
      showCrimes: showCrimes ?? this.showCrimes,
      showOfficers: showOfficers ?? this.showOfficers,
      // focusOnACrime: focusOnACrime ?? this.focusOnACrime,
      focusedCrime: focusedCrime ?? this.focusedCrime,
      predictions: predictions ?? this.predictions,
      crimes: crimes ?? this.crimes,
      officers: officers ?? this.officers,
      currentLat: currentLat ?? this.currentLat,
      currentLong: currentLong ?? this.currentLong,
      pageState: pageState ?? this.pageState,
    );
  }

  @override
  List<Object?> get props => [
        locationStreaming,
        showPredictions,
        showCrimes,
        showOfficers,
        // focusOnACrime,
        focusedCrime,
        predictions,
        crimes,
        officers,
        currentLong,
        currentLat,
        pageState,
      ];

  const MapState.init()
      : this(
          locationStreaming: false,
          showPredictions: false,
          showCrimes: false,
          showOfficers: false,
          // focusOnACrime: false,
          focusedCrime: null,
          predictions: const [],
          crimes: const [],
          officers: const [],
          currentLat: 0,
          currentLong: 0,
          pageState: PageState.init,
        );
}
