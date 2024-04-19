import 'package:flutter/material.dart';

const _borderColor = Colors.black;
const _borderRadius = 8.0;

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.maxLines,
    required this.hintText,
  });

  final TextEditingController controller;
  final int maxLines;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 14),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _borderColor),
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _borderColor),
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _borderColor),
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
          ),
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
          ),
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
      ),
    );
  }
}
