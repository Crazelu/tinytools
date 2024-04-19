import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tools/core/extensions/locale_extension.dart';
import 'package:tools/core/presentation/viewmodel/view_model_provider.dart';
import 'package:tools/core/presentation/widgets/responsive_builder.dart';
import 'package:tools/features/home/presentation/viewmodels/home_view_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
      create: () => HomeViewModel(),
      builder: (context) {
        final viewModel = context.read<HomeViewModel>();

        return ResponsiveWidgetBuilder(
          desktop: Scaffold(
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: FloatingActionButton(
                onPressed: viewModel.increment,
                child: const Icon(Icons.add),
              ),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ValueListenableBuilder(
                    valueListenable: viewModel.counter,
                    builder: (context, count, _) {
                      return Text(
                        'Ella${'!' * count}',
                        style: Theme.of(context).textTheme.headlineMedium,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Language: ${context.locale.language}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
