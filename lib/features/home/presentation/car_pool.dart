import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:some_ride/core/constants/constants.dart';
import 'package:geocoding/geocoding.dart';

import 'package:some_ride/features/home/controllers/home_controller.dart';

class CarPoolHome extends StatefulWidget {
  const CarPoolHome({super.key});

  static Map<PolylineId, Polyline> polylines = {};

  @override
  State<CarPoolHome> createState() => _CarPoolHomeState();
}

class _CarPoolHomeState extends State<CarPoolHome> {
  final controller = Get.find<HomeController>();
  final Completer<GoogleMapController> mapController = Completer();
  final TextEditingController _searchController = TextEditingController();
  void getPolyfromPoints(List<LatLng>? points) {
    PolylineId id = const PolylineId('route');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      width: 5,
      points: points!,
    );
    setState(() {
      CarPoolHome.polylines[id] = polyline;
    });
  }

  List listofPlaces = [];
  String groundURL =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  String tokenForSession = "keith1";

  void makeSuggestion({required String input}) async {
    String request =
        '$groundURL?input=$input&key=$googleApiKey&sessiontoken=$tokenForSession';
    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      setState(() {
        listofPlaces = jsonDecode(response.body)['predictions'];
      });
    }
  }

  void onModify() {
    makeSuggestion(input: _searchController.text);
  }

  @override
  void initState() {
    _searchController.addListener(() {
      if (_searchController.text.isEmpty) {
        setState(() {
          listofPlaces = [];
        });
      }
      onModify();
    });
    super.initState();
  }

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
          Positioned(
            top: 20.0,
            left: 20.0,
            right: 20.0,
            child: searchField(),
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

  Container searchField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
              ),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search for a location',
                    border: InputBorder.none,
                  ),
                  onSubmitted: (value) {
                    makeSuggestion(input: value);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          listofPlaces.isEmpty
              ? const SizedBox()
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: listofPlaces.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        listofPlaces[index]['description'],
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      onTap: () async {
                        List<Location> location = await locationFromAddress(
                            listofPlaces[index]['description']);
                        controller.updateDestinationMarker(
                          LatLng(
                              location.last.latitude, location.last.longitude),
                        );
                        controller.changeDestination(
                          LatLng(
                              location.last.latitude, location.last.longitude),
                        );
                        controller.getPolylinePoints().then(
                              (value) => getPolyfromPoints(value),
                            );
                        _searchController.clear();
                        setState(() {});
                      },
                    );
                  },
                ),
        ],
      ),
    );
  }
}
