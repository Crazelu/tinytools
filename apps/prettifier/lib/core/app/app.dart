import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialog_manager/flutter_dialog_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:prettifier/core/assets/assets.gen.dart';
import 'package:prettifier/core/extensions/locale_extension.dart';
import 'package:prettifier/core/navigation/navigation_listener.dart';
import 'package:prettifier/core/dialog/dialog_generator.dart';
import 'package:prettifier/core/dialog/dialog_handler.dart';
import 'package:prettifier/core/routes/route_generator.dart';
import 'package:prettifier/core/routes/routes.dart';
import 'package:prettifier/core/presentation/widgets/footer.dart';
import 'package:prettifier/core/presentation/widgets/responsive_builder.dart';
import 'package:prettifier/core/localization/app_localizations.dart';

class PrettifierApp extends StatefulWidget {
  const PrettifierApp({super.key});

  @override
  State<PrettifierApp> createState() => _PrettifierAppState();
}

class _PrettifierAppState extends State<PrettifierApp> {
  late final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    precacheImage(PrettifierAssets.logo.provider(), context);

    return DialogManager(
      dialogKey: GetIt.I<DialogHandler>().dialogKey,
      navigatorKey: _navigatorKey,
      onGenerateDialog: DialogGenerator.onGenerateDialog,
      child: MaterialApp(
        scrollBehavior: const _PretifierScrollBehavior(),
        onGenerateTitle: (context) => context.locale.jsonPrettifier,
        theme: ThemeData.dark(),
        localizationsDelegates: const [
          PrettifierLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en')],
        onGenerateRoute: RouteGenerator.onGenerateRoute,
        initialRoute: Routes.home,
        navigatorKey: _navigatorKey,
        builder: (_, child) => NavigationListener(
          navigatorKey: _navigatorKey,
          child: Stack(
            children: [
              child!,
              if (kIsWeb)
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: (10.0, 5.0).resolve,
                      right: (20.0, 20.0).resolve,
                    ),
                    child: const Footer(),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

/// Removes glowing scroll indicator on Android
class _PretifierScrollBehavior extends ScrollBehavior {
  const _PretifierScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}
