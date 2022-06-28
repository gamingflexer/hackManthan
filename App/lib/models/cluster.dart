import 'package:equatable/equatable.dart';

class Cluster extends Equatable {
  final String uid;
  final String eventType;
  // final String description;
  // final String priority;
  final double lat;
  final double long;

  const Cluster({
    this.uid = '',
    this.eventType = '',
    // this.description = '',
    // this.priority = '',
    this.lat = 0,
    this.long = 0,
  });

  static Cluster empty = const Cluster(
    uid: '',
  );

  Cluster.fromJson(Map<String, dynamic> json, String uid)
      : this(
          uid: uid,
          eventType: json['eventType'],
          // description: json['description'],
          // priority: json['priority'],
          lat: json['lat'],
          long: json['long'],
        );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['eventType'] = eventType;
    // data['description'] = description;
    // data['priority'] = priority;
    data['lat'] = lat;
    data['long'] = long;
    return data;
  }

  Cluster copyWith({
    String? uid,
    String? eventType,
    // String? description,
    // String? priority,
    double? lat,
    double? long,
  }) {
    return Cluster(
      uid: uid ?? this.uid,
      eventType: eventType ?? this.eventType,
      // description: description ?? this.description,
      // priority: priority ?? this.priority,
      lat: lat ?? this.lat,
      long: long ?? this.long,
    );
  }

  @override
  String toString() {
    return 'Cluster($uid, $eventType, $lat, $long)';
  }

  @override
  List<Object?> get props => [
        uid,
        eventType,
        // description,
        // priority,
        lat,
        long,
      ];
}
