import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:some_ride/core/constants/constants.dart';
import 'package:http/http.dart' as http;

class SearchBarPage extends StatefulWidget {
  const SearchBarPage({super.key});

  @override
  State<SearchBarPage> createState() => _SearchBarPageState();
}

class _SearchBarPageState extends State<SearchBarPage> {
  final TextEditingController _searchController = TextEditingController();
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
        print(listofPlaces);
      });
    }
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
      child: Row(
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
    );
  }
}
