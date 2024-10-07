import 'package:flutter/material.dart';
import 'package:prettifier/core/extensions/locale_extension.dart';
import 'package:prettifier/features/home/presentation/viewmodels/home_view_model.dart';
import 'package:provider/provider.dart';

class PrettifierTextField extends StatelessWidget {
  const PrettifierTextField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: (value) {
        context.read<HomeViewModel>().prettify(value);
      },
      maxLines: 40,
      cursorColor: Colors.white,
      decoration: InputDecoration(
        hintText: context.locale.enterJSON,
        hintStyle: const TextStyle(color: Colors.white),
        contentPadding: EdgeInsets.zero,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
      ),
    );
  }
}
