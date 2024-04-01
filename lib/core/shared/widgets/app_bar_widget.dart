import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarWidget extends StatelessWidget {
  final bool isBackButton;
  final String title;
  final EdgeInsets? titlePadding;
  final List<Widget>? actions;
  const AppBarWidget({
    super.key,
    this.isBackButton = true,
    required this.title,
    this.titlePadding,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 14.0,
        vertical: 14,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                !isBackButton
                    ? Container()
                    : GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15),
                              ),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            child: const Icon(
                              Icons.keyboard_arrow_left,
                              color: Colors.black,
                              size: 28,
                            )),
                      ),
                Expanded(
                  child: Padding(
                    padding: titlePadding?.copyWith(
                          left: isBackButton ? 17.0 : 10,
                          top: isBackButton ? 0 : 17,
                          bottom: isBackButton ? 0 : 17,
                        ) ??
                        EdgeInsets.only(
                          left: isBackButton ? 17.0 : 10,
                          top: isBackButton ? 0 : 17,
                          bottom: isBackButton ? 0 : 17,
                        ),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // ignore: unnecessary_null_comparison
          actions == null
              ? Container()
              : Row(
                  children: actions!,
                ),
        ],
      ),
    );
  }
}
