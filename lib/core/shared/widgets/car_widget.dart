import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:some_ride/core/shared/styles/colors.dart';

import '../../../features/home/model/export.dart';

Widget buildCar(BuildContext context, Car car, [int? index]) {
  return Container(
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(
        Radius.circular(15),
      ),
    ),
    padding: const EdgeInsets.all(16),
    margin: EdgeInsets.only(
        right: index != null ? 16 : 0, left: index == 0 ? 16 : 0),
    width: 220,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            decoration: BoxDecoration(
              color: kPrimaryColorShadow,
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                car.condition,
                style: GoogleFonts.roboto(
                  color: Theme.of(context).primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 115,
          child: Center(
            child: Hero(
              tag: car.model,
              child: Image.asset(
                car.images[0],
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          car.model,
          style: GoogleFonts.roboto(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
        Text(
          car.brand,
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            height: 1,
            color: Colors.black,
          ),
        ),
        Text(
          "per ${car.condition == "Daily" ? "day" : car.condition == "Weekly" ? "week" : "month"}",
          style: GoogleFonts.roboto(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    ),
  );
}
