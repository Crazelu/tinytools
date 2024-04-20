import 'package:flutter/material.dart';
import 'package:prettifier/core/presentation/widgets/scroll_behavior.dart';
import 'package:prettifier/features/home/presentation/viewmodels/home_view_model.dart';
import 'package:prettifier/features/home/presentation/widgets/textfield.dart';
import 'package:provider/provider.dart';

class MobileHomePage extends StatelessWidget {
  const MobileHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height * 0.3,
          color: const Color(0xFF90B8F8),
          child: const PrettifierTextField(),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            width: MediaQuery.sizeOf(context).width,
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
