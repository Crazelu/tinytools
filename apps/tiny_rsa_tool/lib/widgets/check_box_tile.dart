import 'package:flutter/material.dart';
import 'package:tiny_rsa_tool/widgets/check_box.dart';
import 'package:tiny_rsa_tool/widgets/responsive_builder.dart';

class CustomCheckBoxTile extends StatelessWidget {
  const CustomCheckBoxTile({
    super.key,
    required this.checked,
    this.onTap,
    required this.title,
  });

  final bool checked;
  final Function(bool)? onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        onTap?.call(!checked);
      },
      child: Row(
        children: [
          CustomCheckBox(checked: checked, onTap: onTap),
          SizedBox(width: (8.0, 4.0).resolve),
          Text(title),
        ],
      ),
    );
  }
}
