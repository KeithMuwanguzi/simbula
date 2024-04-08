import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:some_ride/core/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:some_ride/features/home/controllers/home_controller.dart';

class SearchBarPage extends StatefulWidget {
  const SearchBarPage({super.key});

  @override
  State<SearchBarPage> createState() => _SearchBarPageState();
}

class _SearchBarPageState extends State<SearchBarPage> {
  final TextEditingController _searchController = TextEditingController();
  final HomeController controller = Get.find<HomeController>();
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
                        controller.updateDestinationMarker(LatLng(
                            location.last.latitude, location.last.longitude));
                        _searchController.clear();
                      },
                    );
                  },
                ),
        ],
      ),
    );
  }
}
