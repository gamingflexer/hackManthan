import 'package:equatable/equatable.dart';
import 'package:hackmanthan_app/models/cluster.dart';
import 'package:hackmanthan_app/models/crime.dart';
import 'package:hackmanthan_app/models/helper_models.dart';
import 'package:hackmanthan_app/models/alert.dart';
import 'package:hackmanthan_app/models/user.dart';

class MapState extends Equatable {
  final bool locationStreaming;
  final bool showAlerts;
  final bool showCrimes;
  final bool showOfficers;
  final bool showClusters;
  final Crime? focusedCrime;
  final List<Alert> alerts;
  final List<Crime> crimes;
  final List<UserData> officers;
  final List<Cluster> clusters;
  final double currentLat;
  final double currentLong;
  final PageState pageState;

  const MapState({
    required this.locationStreaming,
    required this.showAlerts,
    required this.showCrimes,
    required this.showOfficers,
    required this.focusedCrime,
    required this.showClusters,
    required this.alerts,
    required this.crimes,
    required this.officers,
    required this.clusters,
    required this.currentLat,
    required this.currentLong,
    required this.pageState,
  });

  MapState copyWith({
    bool? locationStreaming,
    bool? showAlerts,
    bool? showCrimes,
    bool? showOfficers,
    bool? showClusters,
    Crime? focusedCrime,
    List<Alert>? alerts,
    List<Crime>? crimes,
    List<UserData>? officers,
    List<Cluster>? clusters,
    double? currentLat,
    double? currentLong,
    PageState? pageState,
  }) {
    return MapState(
      locationStreaming: locationStreaming ?? this.locationStreaming,
      showAlerts: showAlerts ?? this.showAlerts,
      showCrimes: showCrimes ?? this.showCrimes,
      showOfficers: showOfficers ?? this.showOfficers,
      showClusters: showClusters ?? this.showClusters,
      focusedCrime: focusedCrime ?? this.focusedCrime,
      alerts: alerts ?? this.alerts,
      crimes: crimes ?? this.crimes,
      officers: officers ?? this.officers,
      clusters: clusters ?? this.clusters,
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
        showClusters,
        focusedCrime,
        alerts,
        crimes,
        officers,
        clusters,
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
          showClusters: false,
          focusedCrime: null,
          alerts: const [],
          crimes: const [],
          officers: const [],
          clusters: const [],
          currentLat: 0,
          currentLong: 0,
          pageState: PageState.loading,
        );
}
