class UserLocation {
  final double latitude;
  final double longitude;

  UserLocation({
    required this.latitude,
    required this.longitude,
  });

  factory UserLocation.fromJson(Map<String, dynamic> json) {
    return UserLocation(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}

class Event {
  final String name;
  final double latitude;
  final double longitude;
  final String time;
  final String description;
  final String organizers;
  final String imageUrl;
   bool fav;

  Event(
      {required this.name,
      required this.latitude,
      required this.longitude,
      required this.time,
      required this.description,
      required this.organizers,
      required this.imageUrl,required this.fav,});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        name: json['name'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        time: json['time'],
        description: json['description'],
        organizers: json['organizers'],
        imageUrl: json['imageUrl'],
        fav: json['fav']);
  }
}
