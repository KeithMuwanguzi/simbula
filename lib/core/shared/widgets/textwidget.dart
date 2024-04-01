import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double size;
  final Color? color;
  final TextAlign? align;
  const TextWidget({
    super.key,
    required this.text,
    required this.size,
    this.align,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: GoogleFonts.roboto(
        fontSize: size,
        color: color ?? Theme.of(context).textTheme.bodySmall!.color,
      ),
    );
  }
}
