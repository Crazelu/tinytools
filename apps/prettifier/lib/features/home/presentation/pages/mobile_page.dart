import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prettifier/core/presentation/widgets/scroll_behavior.dart';
import 'package:prettifier/features/home/presentation/viewmodels/home_view_model.dart';
import 'package:prettifier/features/home/presentation/widgets/copy_button.dart';
import 'package:prettifier/features/home/presentation/widgets/prettifier_text_field.dart';
import 'package:provider/provider.dart';

class MobileHomePage extends StatelessWidget {
  const MobileHomePage({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<HomeViewModel>();

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height * 0.3,
          color: const Color(0xFF90B8F8),
          child: PrettifierTextField(controller: controller),
        ),
        Expanded(
          child: Stack(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height * 0.7,
                color: const Color(0xFF5F85DB),
                child: ScrollConfiguration(
                  behavior: const PrettifierScrollBehavior(),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 80),
                    child: ValueListenableBuilder<String>(
                      valueListenable: viewModel.prettifiedJSON,
                      builder: (context, prettifiedJSON, _) {
                        return SelectableText(
                          prettifiedJSON,
                          style: Theme.of(context).textTheme.bodyLarge,
                        );
                      },
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 16,
                child: ValueListenableBuilder(
                  valueListenable: viewModel.prettifiedJSON,
                  builder: (context, prettifiedJSON, _) {
                    if (prettifiedJSON.isEmpty) return const SizedBox.shrink();
                    return CopyButton(
                      onCopy: () {
                        return Clipboard.setData(
                          ClipboardData(text: prettifiedJSON),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
