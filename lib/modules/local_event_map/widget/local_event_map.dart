import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:local_event_finder/global/model/local_event.dart';
import 'package:local_event_finder/global/tools/widgets/drawer.dart';

class LocalEventMap extends StatefulWidget {
  static const routeName = '/LocalEventMap-widget';
  const LocalEventMap({super.key});

  @override
  State<LocalEventMap> createState() => _LocalEventMapState();
}

class _LocalEventMapState extends State<LocalEventMap> {
  late GoogleMapController mapController;
  late LatLng initialPosition;
  bool isLoading = true;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    _loadJsonData().then((jsonData) {
      setState(() {
        _events = _parseEvents(jsonData);
      });
    });
    initializeLocation();
  }

  List<Event> _events = [];

  Future<String> _loadJsonData() async {
    return await rootBundle.loadString('assets/dummydata.json');
  }

  List<Event> _parseEvents(String jsonData) {
    Map<String, dynamic> data = jsonDecode(jsonData);
    List<Event> events = [];
    for (var eventJson in data['events']) {
      Event event = Event.fromJson(eventJson);
      events.add(event);
    }
    return events;
  }

  Set<Marker> _createMarkers() {
    Set<Marker> markers = _events.map((event) {
      return Marker(
        markerId: MarkerId(event.name),
        position: LatLng(event.latitude, event.longitude),
        infoWindow: InfoWindow(
          title: event.name,
          snippet: event.description,
        ),
      );
    }).toSet();
    markers.add(
      Marker(
        markerId: MarkerId('userLocation'),
        position: initialPosition,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: InfoWindow(
          title: 'Your Location',
        ),
      ),
    );
    return markers;
  }

  void initializeLocation() async {
    LocationPermission permission;
    permission = await Geolocator
        .requestPermission(); //il faut toujours ajouter ce ligne de code afin de prendre la permission de localiser le current device
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      initialPosition = LatLng(position.latitude, position.longitude);
      isLoading = false;
      print("pos ---> $position");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Local Events Map'),
      ),
      drawer: const AppMainDrawer(),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(), // Loading widget
            )
          : GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: initialPosition,
                zoom: 17,
              ),
              markers: _createMarkers()),
    );
  }
}
