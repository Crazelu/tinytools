import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({
    super.key,
    required this.checked,
    this.onTap,
  });

  final bool checked;
  final Function(bool)? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call(!checked);
      },
      child: Container(
        height: 16,
        width: 16,
        decoration: BoxDecoration(
          color: checked ? Colors.green : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: checked ? Colors.green : Colors.grey.shade500,
          ),
        ),
        child: checked
            ? Icon(
                Icons.check,
                size: 14,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}
