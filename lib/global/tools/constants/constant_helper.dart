import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:local_event_finder/global/model/local_event.dart';
import 'package:flutter/services.dart' show rootBundle;

class ConstantHelper {
  static User? user;
  static List<Event>? events;
  static List<Event>? favoritesEvents;
  static bool emptyFavorites = true;
  // Assuming you have the JSON data stored in a string variable called 'jsonData'
  Future<String> loadJsonData() async {
    return await rootBundle.loadString('assets/dummydata.json');
  }

  void parseJsonData(String jsonData) {
    Map<String, dynamic> data = jsonDecode(jsonData);

    UserLocation userLocation = UserLocation.fromJson(data['userLocation']);
    double userLatitude = userLocation.latitude;
    double userLongitude = userLocation.longitude;

    events = List<Event>.from(
        data['events'].map((eventJson) => Event.fromJson(eventJson)));
    print("data: ${events}");
    // Now you have access to the user's location and the list of events as objects
    // You can use these objects to perform any necessary operations in your Flutter app
  }
}
