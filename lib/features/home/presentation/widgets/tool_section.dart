import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tools/core/assets/assets.gen.dart';
import 'package:tools/core/extensions/locale_extension.dart';
import 'package:tools/core/presentation/widgets/responsive_builder.dart';
import 'package:tools/features/home/presentation/viewmodels/home_view_model.dart';

class ToolSection extends StatelessWidget {
  const ToolSection(
      {super.key,
      required this.title,
      required this.description,
      required this.url,
      required this.image,
      this.imageSize = 32});

  final String title;
  final String description;
  final String url;
  final AssetGenImage image;
  final double imageSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            image.image(
              height: (imageSize, imageSize - 8).resolve,
              width: (imageSize, imageSize - 8).resolve,
            ),
            const SizedBox(width: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            )
          ],
        ),
        SizedBox(height: (8.0, 4.0).resolve),
        Text(
          description,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () {
            context.read<HomeViewModel>().launchUrl(url, title);
          },
          child: Text(
            '👉🏽 ${context.locale.tryItHere}',
          ),
        ),
        SizedBox(height: (36.0, 24.0).resolve),
      ],
    );
  }
}
