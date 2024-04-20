import 'package:flutter/material.dart';
import 'package:prettifier/core/assets/assets.gen.dart';
import 'package:prettifier/core/extensions/locale_extension.dart';
import 'package:prettifier/features/home/presentation/pages/desktop_page.dart';
import 'package:prettifier/features/home/presentation/pages/mobile_page.dart';
import 'package:prettifier/core/presentation/viewmodel/view_model_provider.dart';
import 'package:prettifier/core/presentation/widgets/responsive_builder.dart';
import 'package:prettifier/features/home/presentation/viewmodels/home_view_model.dart';
import "package:universal_html/html.dart" as html;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
      create: () => HomeViewModel(),
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: kToolbarHeight * 1.4,
            backgroundColor: const Color(0xFF26282B),
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PrettifierAssets.logo.image(
                      height: (40.0, 32.0).resolve,
                      width: (40.0, 32.0).resolve,
                    ),
                    const SizedBox(width: 8),
                    SelectableText(
                      context.locale.jsonPrettifier,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                InkWell(
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    html.window.open(
                      'https://tools.luckyebere.com/',
                      "Lucky's Tools",
                    );
                  },
                  child: Text(
                    "From Lucky's Tools",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFFB9D2D2),
                        ),
                  ),
                ),
              ],
            ),
          ),
          body: const ResponsiveWidgetBuilder(
            desktop: DesktopHomePage(),
            mobile: MobileHomePage(),
          ),
        );
      },
    );
  }
}
