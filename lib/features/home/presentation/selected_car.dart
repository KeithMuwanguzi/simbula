import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/shared/widgets/export.dart';

class SelectedCar extends StatelessWidget {
  final String brand;
  final String model;
  final double price;
  final String condition;
  final List<String> images;
  const SelectedCar({
    super.key,
    required this.brand,
    required this.model,
    required this.price,
    required this.condition,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          decoration: BoxDecoration(color: Colors.grey[200]),
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildHeader(context),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                child: Column(
                  children: [
                    Text(
                      'SPECIFICATIONS',
                      style: GoogleFonts.roboto(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // buildSpecs("Condition", condition),
                        // buildSpecs("Model", model),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBarWidget(
            title: "",
            isBackButton: true,
            actions: [
              Container(
                margin: const EdgeInsets.all(8),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue[800],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.bookmark,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.upload,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 22),
          CarImagesWidget(images: images),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CarNameWidget(
                  model: model,
                  brand: brand,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildPeriodContainer("12 Months", "10% Off", "\$$price", true),
                buildPeriodContainer(
                    "6 Months", "5% Off", "\$${price / 2}", false),
                buildPeriodContainer(
                    "3 Months", "2% Off", "\$${price / 4}", false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildPeriodContainer(String s, String t, String u, bool selected) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: selected ? Colors.blue[800] : Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: selected ? Colors.blue[800]! : Colors.grey[300]!,
        ),
      ),
      child: Column(
        children: [
          Text(
            s,
            style: GoogleFonts.roboto(
              fontSize: 15,
              color: selected ? Colors.grey[200] : Colors.grey,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            t,
            style: GoogleFonts.roboto(
              fontSize: 20,
              color: selected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            u,
            style: GoogleFonts.roboto(
              fontSize: 15,
              color: selected ? Colors.grey[200] : Colors.blue[800],
            ),
          ),
        ],
      ),
    );
  }

  // buildSpecs(String s, String condition) {
  //   Container(
  //     color: Colors.white,
  //     padding: const EdgeInsets.symmetric(vertical: 10),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Text(
  //           s,
  //           style: GoogleFonts.roboto(
  //             fontSize: 15,
  //             color: Colors.black,
  //           ),
  //         ),
  //         Text(
  //           condition,
  //           style: GoogleFonts.roboto(
  //             fontSize: 15,
  //             color: Colors.grey,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
