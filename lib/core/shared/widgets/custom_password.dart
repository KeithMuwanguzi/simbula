import 'package:flutter/material.dart';

class CustomPasswordFormField extends StatelessWidget {
  final TextEditingController controller;
  final bool isVisible;
  final VoidCallback userFunction;
  final String hintText;
  // ignore: prefer_typing_uninitialized_variables
  final validate;
  const CustomPasswordFormField(
      {super.key,
      required this.userFunction,
      required this.controller,
      required this.hintText,
      required this.isVisible,
      required this.validate});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isVisible,
      validator: validate,
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
