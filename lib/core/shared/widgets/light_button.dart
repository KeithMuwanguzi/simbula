import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LightBorderButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback buttonFunction;
  const LightBorderButton({
    super.key,
    required this.buttonText,
    required this.buttonFunction,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonFunction,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).primaryColor,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: GoogleFonts.poppins(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
