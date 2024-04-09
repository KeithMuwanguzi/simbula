import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:some_ride/core/constants/constants.dart';

import '../widgets/bottom_item.dart';

class HomeController extends GetxController {
  LatLng userLocation = const LatLng(0, 0);
  var loading = true.obs;

  @override
  void onInit() async {
    super.onInit();
    await checkPermissionsAndGetCurrentUserLocation();
    loading.value = false;
  }

  TextEditingController search = TextEditingController();

  var isRenting = false.obs;
  var navBarIndex = 0.obs;

  List<BottomItem> items = [
    const BottomItem(label: 'Home', icon: Icons.home),
    const BottomItem(label: 'Favorites', icon: Icons.favorite_border),
    const BottomItem(label: 'Wallet', icon: Icons.wallet),
    const BottomItem(label: 'Offers', icon: Icons.local_offer_sharp),
    const BottomItem(label: 'Profile', icon: Icons.person_pin_rounded),
  ];

  final RxInt currentPage = 0.obs;

  // Method to change the current page
  void changePage(int index) {
    currentPage.value = index;
  }

  void toggleRenting() {
    isRenting.value = !isRenting.value;
  }

  checkPermissionsAndGetCurrentUserLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      await Geolocator.requestPermission();
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        userLocation = const LatLng(0, 0);
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    userLocation = LatLng(position.latitude, position.longitude);
  }

  GoogleMapController? mapController;

  final Rx<Marker> destinationMarker = Marker(
    markerId: const MarkerId('destination'),
    position: const LatLng(0.0, 0.0),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
  ).obs;

  void updateDestinationMarker(LatLng position) {
    destinationMarker.value = Marker(
      markerId: const MarkerId('destination'),
      position: position,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    );
  }

  Polyline drawPolyline() {
    Polyline polyline = Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.blue,
      width: 5,
      points: [
        userLocation, // User's current location
        destinationMarker.value.position, // Updated destination
      ],
    );
    return polyline;
  }

  Future<List<LatLng>> getPolylinePoints() async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(userLocation.latitude, userLocation.longitude),
      PointLatLng(destinationMarker.value.position.latitude,
          destinationMarker.value.position.longitude),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    return polylineCoordinates;
  }
}
