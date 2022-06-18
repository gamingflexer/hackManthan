import 'package:equatable/equatable.dart';

class LatLong extends Equatable {
  final double lat;
  final double long;

  const LatLong({
    this.lat = 0,
    this.long = 0,
  });

  LatLong copyWith({
    double? lat,
    double? long,
  }) {
    return LatLong(
      lat: lat ?? this.lat,
      long: long ?? this.long,
    );
  }

  @override
  List<Object?> get props => [
        lat,
        long,
      ];
}
