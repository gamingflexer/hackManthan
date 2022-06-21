import 'package:equatable/equatable.dart';

class Alert extends Equatable {
  final String uid;
  final String title;
  final String description;
  final String priority;
  final double lat;
  final double long;

  const Alert({
    this.uid = '',
    this.title = '',
    this.description = '',
    this.priority = '',
    this.lat = 0,
    this.long = 0,
  });

  static Alert empty = const Alert(
    uid: '',
  );

  Alert.fromJson(Map<String, dynamic> json, String uid)
      : this(
          uid: uid,
          title: json['title'],
          description: json['description'],
          priority: json['priority'],
          lat: json['lat'],
          long: json['long'],
        );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['priority'] = priority;
    data['lat'] = lat;
    data['long'] = long;
    return data;
  }

  Alert copyWith({
    String? uid,
    String? title,
    String? description,
    String? priority,
    double? lat,
    double? long,
  }) {
    return Alert(
      uid: uid ?? this.uid,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      lat: lat ?? this.lat,
      long: long ?? this.long,
    );
  }

  @override
  String toString() {
    return 'Alert($uid, $title, $description, $priority, $lat, $long)';
  }

  @override
  List<Object?> get props => [
        uid,
        title,
        description,
        priority,
        lat,
        long,
      ];
}
