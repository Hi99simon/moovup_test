import 'dart:convert';

class User {
  final String id;
  final Name name;
  final String email;
  final String picture;
  final Location? location;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.picture,
    this.location,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: Name.fromJson(json['name']),
      email: json['email'],
      picture: json['picture'],
      location: json['location'] != null ? Location.fromJson(json['location']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name.toJson(),
      'email': email,
      'picture': picture,
      'location': location?.toJson(),
    };
  }
}

class Name {
  final String last;
  final String first;

  Name({
    required this.last,
    required this.first,
  });

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      last: json['last'],
      first: json['first'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'last': last,
      'first': first,
    };
  }
}

class Location {
  final double? latitude;
  final double? longitude;

  Location({
    required this.latitude,
    this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
