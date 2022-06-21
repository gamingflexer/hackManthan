import 'package:equatable/equatable.dart';
import 'package:hackmanthan_app/models/crime.dart';
import 'package:hackmanthan_app/models/helper_models.dart';
import 'package:hackmanthan_app/models/alert.dart';
import 'package:hackmanthan_app/models/user.dart';

class MapState extends Equatable {
  final bool locationStreaming;
  final bool showAlerts;
  final bool showCrimes;
  final bool showOfficers;
  // final bool focusOnACrime;
  final Crime? focusedCrime;
  final List<Alert> alerts;
  final List<Crime> crimes;
  final List<UserData> officers;
  final double currentLat;
  final double currentLong;
  final PageState pageState;

  const MapState({
    required this.locationStreaming,
    required this.showAlerts,
    required this.showCrimes,
    required this.showOfficers,
    required this.focusedCrime,
    // required this.focusOnACrime,
    required this.alerts,
    required this.crimes,
    required this.officers,
    required this.currentLat,
    required this.currentLong,
    required this.pageState,
  });

  MapState copyWith({
    bool? locationStreaming,
    bool? showAlerts,
    bool? showCrimes,
    bool? showOfficers,
    // bool? focusOnACrime,
    Crime? focusedCrime,
    List<Alert>? alerts,
    List<Crime>? crimes,
    List<UserData>? officers,
    double? currentLat,
    double? currentLong,
    PageState? pageState,
  }) {
    return MapState(
      locationStreaming: locationStreaming ?? this.locationStreaming,
      showAlerts: showAlerts ?? this.showAlerts,
      showCrimes: showCrimes ?? this.showCrimes,
      showOfficers: showOfficers ?? this.showOfficers,
      // focusOnACrime: focusOnACrime ?? this.focusOnACrime,
      focusedCrime: focusedCrime ?? this.focusedCrime,
      alerts: alerts ?? this.alerts,
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
        showAlerts,
        showCrimes,
        showOfficers,
        // focusOnACrime,
        focusedCrime,
        alerts,
        crimes,
        officers,
        currentLong,
        currentLat,
        pageState,
      ];

  const MapState.init()
      : this(
          locationStreaming: false,
          showAlerts: false,
          showCrimes: false,
          showOfficers: false,
          // focusOnACrime: false,
          focusedCrime: null,
          alerts: const [],
          crimes: const [],
          officers: const [],
          currentLat: 0,
          currentLong: 0,
          pageState: PageState.loading,
        );
}
