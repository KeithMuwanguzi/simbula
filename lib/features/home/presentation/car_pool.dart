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
          const Positioned(
            top: 20.0,
            left: 20.0,
            right: 20.0,
            child: SearchBar(),
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

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              handleSearch();
            },
          ),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search destination',
                border: InputBorder.none,
              ),
              onSubmitted: (value) {
                handleSearch();
              },
            ),
          ),
        ],
      ),
    );
  }

  void handleSearch() {}
}
