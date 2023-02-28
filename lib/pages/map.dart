import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'dart:developer';
// import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:location/location.dart';

class Map extends StatefulWidget {
  const Map({super.key});
  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  // static const CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);

  CameraPosition _currentLocation = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(47.732994, -122.197669),
    // tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );

  // / Determine the current position of the device.
  // /
  // / When the location services are not enabled or permissions
  // / are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    // return await Geolocator.getCurrentPosition();
    Position position = await Geolocator.getCurrentPosition();
    _currentLocation = CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 19.151926040649414,
    );
    return position;
  }

// created method for getting user current location
  // Future<Position> getUserCurrentLocation() async {
  //   await Geolocator.requestPermission()
  //       .then((value) {})
  //       .onError((error, stackTrace) async {
  //     await Geolocator.requestPermission();
  //     print("ERROR" + error.toString());
  //   });
  //   return await Geolocator.getCurrentPosition();
  // }

  // on below line we have created the list of markers
  final List<Marker> _markers = <Marker>[
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(20.42796133580664, 75.885749655962),
        infoWindow: InfoWindow(
          title: 'My Position',
        )),
  ];

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        markers: Set<Marker>.of(_markers),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
      // on pressing floating action button the camera will take to user current location
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     _determinePosition().then((value) async {
      //       print(value.latitude.toString() + " " + value.longitude.toString());

      //       // marker added for current users location
      //       _markers.add(Marker(
      //         markerId: MarkerId("2"),
      //         position: LatLng(value.latitude, value.longitude),
      //         infoWindow: InfoWindow(
      //           title: 'My Current Location',
      //         ),
      //       ));

      //       // specified current users location
      //       CameraPosition cameraPosition = new CameraPosition(
      //         target: LatLng(value.latitude, value.longitude),
      //         zoom: 14,
      //       );

      //       final GoogleMapController controller = await _controller.future;
      //       controller
      //           .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      //       setState(() {});
      //     });
      //   },
      //   child: Icon(Icons.local_activity),
      // ),
    );
  }

  Future<void> _goToTheLake() async {
    log("Testing go to lake button console log.");
    print("Test2 console log.");
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_currentLocation));
  }
}
