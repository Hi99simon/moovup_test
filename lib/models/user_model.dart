

class User {
  final String id;
  final Name name;
  final String email;
  final String picture;
  final Location location;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.picture,
   required this.location,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: Name.fromJson(json['name']),
      email: json['email'],
      picture: json['picture'],
      location: Location.fromJson(json['location']),
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
    this.latitude,
    this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    double? lat = json['latitude'] is double ? json['latitude'] : null;
    double? lng = json['longitude'] is double ? json['longitude'] : null;


    return Location(
      latitude: lat,
      longitude: lng,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
