import 'package:flutter/material.dart';
import 'package:tools/core/assets/assets.gen.dart';
import 'package:tools/core/extensions/locale_extension.dart';
import 'package:tools/core/presentation/viewmodel/view_model_provider.dart';
import 'package:tools/core/presentation/widgets/responsive_builder.dart';
import 'package:tools/core/presentation/widgets/scroll_behavior.dart';
import 'package:tools/features/home/presentation/viewmodels/home_view_model.dart';
import 'package:tools/features/home/presentation/widgets/tool_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
      create: () => HomeViewModel(),
      builder: (context) {
        return ResponsiveWidgetBuilder(
          desktop: Scaffold(
            appBar: AppBar(
              surfaceTintColor: Colors.transparent,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TinyToolsAssets.logo.image(
                    height: (40.0, 32.0).resolve,
                    width: (40.0, 32.0).resolve,
                  ),
                  Text(
                    context.locale.luckysTools,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  child: Text(
                    context.locale.luckysToolsDescription,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                SizedBox(height: (12.0, 8.0).resolve),
                Expanded(
                  child: ScrollConfiguration(
                    behavior: const TinyToolsScrollBehavior(),
                    child: ListView(
                      padding: EdgeInsets.symmetric(
                        horizontal: (
                          MediaQuery.sizeOf(context).width * 0.3,
                          16.0
                        ).resolve,
                        vertical: (100.0, 16.0).resolve,
                      ),
                      children: [
                        ToolSection(
                          title: context.locale.tinyRsaTool,
                          description: context.locale.tinyRsaToolDescription,
                          url: 'https://rsa.luckyebere.com',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
