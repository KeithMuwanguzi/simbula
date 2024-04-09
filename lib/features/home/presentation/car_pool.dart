import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:some_ride/features/home/controllers/home_controller.dart';
import 'package:some_ride/features/home/presentation/search_bar.dart';

class CarPoolHome extends GetView<HomeController> {
  const CarPoolHome({super.key});

  @override
  Widget build(BuildContext context) {
    final Completer<GoogleMapController> _controller = Completer();

    return Scaffold(
      body: Stack(
        children: [
          Obx(
            () => controller.loading.value ? loadingMap() : loadMap(),
          ),
          const Positioned(
            top: 20.0,
            left: 20.0,
            right: 20.0,
            child: SearchBarPage(),
          )
        ],
      ),
    );
  }

  GoogleMap loadMap() {
    return GoogleMap(
      initialCameraPosition: const CameraPosition(
        target: LatLng(0, 0),
        zoom: 15,
      ),
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      zoomControlsEnabled: true,
      onMapCreated: (GoogleMapController mapController) {
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
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ),
        controller.destinationMarker.value,
      },
      polylines:
          controller.destinationMarker.value.position != const LatLng(0, 0)
              ? {controller.drawPolyline()}
              : {},
    );
  }

  Center loadingMap() {
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
