import 'package:flutter/material.dart';

class CustomPasswordFormField extends StatelessWidget {
  final TextEditingController controller;
  final bool isVisible;
  final VoidCallback userFunction;
  final String hintText;
  const CustomPasswordFormField({
    super.key,
    required this.userFunction,
    required this.controller,
    required this.hintText,
    required this.isVisible,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isVisible,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          suffixIcon: IconButton(
            onPressed: userFunction,
            icon: isVisible == true
                ? const Icon(Icons.visibility)
                : const Icon(Icons.visibility_off),
          )),
    );
  }
}
