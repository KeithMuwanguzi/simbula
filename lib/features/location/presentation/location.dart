import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EnableLocation extends StatelessWidget {
  const EnableLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          Image.asset(
            'assets/images/map2.jpeg',
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 250, 40, 30),
            child: Container(
              width: double.infinity,
              height: 450,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(30.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 40,
                      child: Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Enable Location",
                    style: GoogleFonts.roboto(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Enable location on your phone for seameless functionality",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: Colors.grey[400],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 20, 25, 10),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            "Use Location",
                            style: GoogleFonts.poppins(
                              fontSize: 17,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/welcome');
                    },
                    child: Text(
                      "Skip For Now",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
