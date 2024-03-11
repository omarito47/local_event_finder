import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

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
    initializeLocation();
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
      print(position);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Map Screen'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(), // Loading widget
            )
          : GoogleMap(
            onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: initialPosition,
                zoom: 15,
              ),
              markers: Set<Marker>.from([
                Marker(
                  markerId: MarkerId('currentLocation'),
                  position: initialPosition,
                ),
              ]),
            ),
    );
  }
}
