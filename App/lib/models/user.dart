import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserData extends Equatable {
  final String uid;
  final String email;
  final String name;
  final String policeId;
  final String post;
  final String ward;
  final String district;
  final String policeStation;
  final double lat;
  final double long;
  final Timestamp lastUpdated;

  const UserData({
    this.uid = '',
    this.email = '',
    this.name = '',
    this.policeId = '',
    this.post = '',
    this.ward = '',
    this.district = '',
    this.policeStation = '',
    this.lat = 0,
    this.long = 0,
    required this.lastUpdated,
  });

  static UserData fromUser(User user) {
    return UserData(
      uid: user.uid,
      email: user.email ?? '',
      lastUpdated: Timestamp.now(),
    );
  }

  static UserData empty = UserData(
    uid: '',
    lastUpdated: Timestamp(0, 0),
  );

  UserData.fromJson(Map<String, dynamic> json, String uid)
      : this(
          uid: uid,
          email: json['email'],
          name: json['name'],
          policeId: json['policeId'],
          post: json['post'],
          ward: json['ward'],
          district: json['district'],
          policeStation: json['policeStation'],
          lat: json['lat'],
          long: json['long'],
          lastUpdated: json['lastUpdated'],
        );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['email'] = email;
    data['name'] = name;
    data['policeId'] = policeId;
    data['post'] = post;
    data['ward'] = ward;
    data['district'] = district;
    data['policeStation'] = policeStation;
    data['lat'] = lat;
    data['long'] = long;
    data['lastUpdated'] = lastUpdated;
    return data;
  }

  UserData copyWith({
    String? uid,
    String? email,
    String? name,
    String? policeId,
    String? post,
    String? ward,
    String? district,
    String? policeStation,
    double? lat,
    double? long,
    Timestamp? lastUpdated,
  }) {
    return UserData(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      policeId: policeId ?? this.policeId,
      post: post ?? this.post,
      ward: ward ?? this.ward,
      district: district ?? this.district,
      policeStation: policeStation ?? this.policeStation,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  bool get isEmpty => this == UserData.empty;

  bool get isNotEmpty => this != UserData.empty;

  @override
  String toString() {
    return 'UserData($uid, $email, $name, $policeId, $post, $ward, $district, $policeStation, $lat, $long, $lastUpdated)';
  }

  @override
  List<Object?> get props => [
        uid,
        email,
        name,
        policeId,
        post,
        ward,
        district,
        policeStation,
        lat,
        long,
        lastUpdated,
      ];
}
