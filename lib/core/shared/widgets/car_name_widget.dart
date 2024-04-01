import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CarNameWidget extends StatelessWidget {
  const CarNameWidget({
    super.key,
    required this.model,
    required this.brand,
  });

  final String model;
  final String brand;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            model,
            style: GoogleFonts.roboto(
              color: Colors.grey,
              fontSize: 20,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            brand,
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
