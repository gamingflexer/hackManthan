import 'package:equatable/equatable.dart';

class Prediction extends Equatable {
  final String uid;
  final String eventId;
  final String eventType;
  final String eventSubType;
  final String circle;
  final String ward;
  final String district;
  final String policeStation;
  final double lat;
  final double long;
  final bool isViolent;
  // final Timestamp time;

  const Prediction({
    this.uid = '',
    this.eventId = '',
    this.eventType = '',
    this.eventSubType = '',
    this.circle = '',
    this.ward = '',
    this.district = '',
    this.policeStation = '',
    this.lat = 0,
    this.long = 0,
    this.isViolent = false,
  });

  static Prediction empty = const Prediction(
    uid: '',
    // time: Timestamp(0, 0),
  );

  Prediction.fromJson(Map<String, dynamic> json)
      : this(
          uid: json['uid'],
          eventId: json['eventId'],
          eventType: json['eventType'],
          eventSubType: json['eventSubType'],
          circle: json['circle'],
          ward: json['ward'],
          district: json['district'],
          policeStation: json['policeStation'],
          lat: json['lat'],
          long: json['long'],
          isViolent: json['isViolent'],
        );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['eventId'] = eventId;
    data['eventType'] = eventType;
    data['eventSubType'] = eventSubType;
    data['circle'] = circle;
    data['ward'] = ward;
    data['district'] = district;
    data['policeStation'] = policeStation;
    data['lat'] = lat;
    data['long'] = long;
    data['isViolent'] = isViolent;
    return data;
  }

  Prediction copyWith({
    String? uid,
    String? eventId,
    String? eventType,
    String? eventSubType,
    String? circle,
    String? ward,
    String? district,
    String? policeStation,
    double? lat,
    double? long,
    bool? isViolent,
  }) {
    return Prediction(
      uid: uid ?? this.uid,
      eventId: eventId ?? this.eventId,
      eventType: eventType ?? this.eventType,
      eventSubType: eventSubType ?? this.eventSubType,
      circle: circle ?? this.circle,
      ward: ward ?? this.ward,
      district: district ?? this.district,
      policeStation: policeStation ?? this.policeStation,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      isViolent: isViolent ?? this.isViolent,
    );
  }

  @override
  String toString() {
    return 'Prediction($uid, $eventId, $eventType, $eventSubType, $circle, $ward, $district, $policeStation, $lat, $long, $isViolent)';
  }

  @override
  List<Object?> get props => [
        uid,
        eventId,
        eventType,
        eventSubType,
        circle,
        ward,
        district,
        policeStation,
        lat,
        long,
        isViolent,
      ];
}
