import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:some_ride/features/home/controllers/home_controller.dart';

class CarPoolHome extends GetView<HomeController> {
  const CarPoolHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Obx(
            () => controller.loading.value ? loadingMap() : loadMap(),
          ),
          Positioned(
            top: 20,
            left: 10,
            child: IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
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
        // Set the initial camera position
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
      },
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
