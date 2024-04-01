import "package:flutter/material.dart";

class RentalHome extends StatelessWidget {
  const RentalHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Welcome to the Rental Home'),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
