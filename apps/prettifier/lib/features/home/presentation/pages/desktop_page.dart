import 'package:flutter/material.dart';
import 'package:prettifier/core/presentation/widgets/scroll_behavior.dart';
import 'package:prettifier/features/home/presentation/viewmodels/home_view_model.dart';
import 'package:prettifier/features/home/presentation/widgets/textfield.dart';
import 'package:provider/provider.dart';

class DesktopHomePage extends StatelessWidget {
  const DesktopHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          width: MediaQuery.sizeOf(context).width * 0.4,
          height: MediaQuery.sizeOf(context).height,
          color: const Color(0xFF90B8F8),
          child: const PrettifierTextField(),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            height: MediaQuery.sizeOf(context).height,
            color: const Color(0xFF5F85DB),
            child: ScrollConfiguration(
              behavior: const PrettifierScrollBehavior(),
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 80),
                child: ValueListenableBuilder<String>(
                  valueListenable: context.read<HomeViewModel>().prettifiedJSON,
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
        ),
      ],
    );
  }
}
