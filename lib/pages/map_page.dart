import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class GoogleMapsComponent extends StatefulWidget {
  final LatLng location;

  const GoogleMapsComponent({required this.location, Key? key})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GoogleMapsComponentState createState() => _GoogleMapsComponentState();
}

class _GoogleMapsComponentState extends State<GoogleMapsComponent> {
  late GoogleMapController _controller;
  late Position _currentPosition = Position(
      longitude: widget.location.longitude,
      latitude: widget.location.latitude,
      timestamp: DateTime.now(),
      accuracy: 0.0,
      altitude: 0.0,
      heading: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0);
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    permission = await Geolocator.checkPermission();

    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = Position(
        latitude: position.latitude,
        longitude: position.longitude,
        timestamp: DateTime.now(),
        accuracy: position.accuracy,
        altitude: position.altitude,
        heading: position.heading,
        speed: position.speed,
        speedAccuracy: position.speedAccuracy,
      );
    });
  }

  // Future<void> _onSearchButtonPressed() async {
  //   List<Location> locations = await locationFromAddress(_searchQuery);
  //   if (locations.isEmpty) {
  //     // Handle no results found
  //     return;
  //   }
  //   Location location = locations.first;
  //   LatLng latLng = LatLng(location.latitude, location.longitude);
  //   _controller.animateCamera(CameraUpdate.newCameraPosition(
  //     CameraPosition(
  //       target: latLng,
  //       zoom: 14,
  //     ),
  //   ));
  // }

//   Future<void> _onSearchButtonPressed() async {
//   List<Location> locations = await locationFromAddress(_searchQuery);
//   if (locations.isEmpty) {
//     // Show an error message
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Location not found'),
//         duration: Duration(seconds: 3),
//       ),
//     );
//     return;
//   }
//   Location location = locations.first;
//   LatLng latLng = LatLng(location.latitude, location.longitude);
//   _controller.animateCamera(CameraUpdate.newCameraPosition(
//     CameraPosition(
//       target: latLng,
//       zoom: 14,
//     ),
//   ));
// }

  Future<void> _onSearchButtonPressed() async {
    try {
      List<Location> locations = await locationFromAddress(_searchQuery);
      if (locations.isEmpty) {
        // Handle no results found
        throw Exception("No results found");
      }
      Location location = locations.first;
      LatLng latLng = LatLng(location.latitude, location.longitude);
      _controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: latLng,
          zoom: 14,
        ),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) => _controller = controller,
            initialCameraPosition: CameraPosition(
              target:
                  LatLng(_currentPosition.latitude, _currentPosition.longitude),
              zoom: 14,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 80,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  _searchQuery = value;
                },
                onSubmitted: (value) {
                  _onSearchButtonPressed();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
