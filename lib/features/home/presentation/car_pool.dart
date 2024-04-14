import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:some_ride/features/home/controllers/home_controller.dart';
import 'package:some_ride/features/home/presentation/search_bar.dart';

class CarPoolHome extends StatefulWidget {
  const CarPoolHome({super.key});

  static Map<PolylineId, Polyline> polylines = {};

  @override
  State<CarPoolHome> createState() => _CarPoolHomeState();
}

class _CarPoolHomeState extends State<CarPoolHome> {
  final controller = Get.find<HomeController>();
  final Completer<GoogleMapController> mapController = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Obx(
            () => controller.loading.value
                ? waitingloadingMap()
                : loadMap(controller, mapController),
          ),
          const Positioned(
            top: 20.0,
            left: 20.0,
            right: 20.0,
            child: SearchBarPage(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }

  GoogleMap loadMap(controller, passedController) {
    return GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(0, 0),
          zoom: 15,
        ),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
        onMapCreated: (GoogleMapController mapController) {
          passedController.complete(mapController);
          mapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: controller.userLocation,
                zoom: 17,
              ),
            ),
          );
        },
        markers: {
          Marker(
            markerId: const MarkerId('user'),
            position: controller.userLocation,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
          ),
          controller.destinationMarker.value,
        },
        polylines: Set<Polyline>.of(CarPoolHome.polylines.values));
  }

  Center waitingloadingMap() {
    return const Center(
      child: AlertDialog(
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 20),
            Text('Please wait...'),
          ],
        ),
      ),
    );
  }
}
