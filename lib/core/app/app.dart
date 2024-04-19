import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dialog_manager/flutter_dialog_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tools/core/navigation/navigation_listener.dart';
import 'package:tools/core/dialog/dialog_generator.dart';
import 'package:tools/core/dialog/dialog_handler.dart';
import 'package:tools/core/routes/route_generator.dart';
import 'package:tools/core/routes/routes.dart';
import 'package:tools/core/presentation/widgets/footer.dart';
import 'package:tools/core/presentation/widgets/responsive_builder.dart';
import 'package:tools/core/localization/app_localizations.dart';

class TinyToolsApp extends StatefulWidget {
  const TinyToolsApp({super.key});

  @override
  State<TinyToolsApp> createState() => _TinyToolsAppState();
}

class _TinyToolsAppState extends State<TinyToolsApp> {
  late final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return DialogManager(
      dialogKey: GetIt.I<DialogHandler>().dialogKey,
      navigatorKey: _navigatorKey,
      onGenerateDialog: DialogGenerator.onGenerateDialog,
      child: MaterialApp(
        scrollBehavior: const _TinyToolsScrollBehavior(),
        title: 'TinyTools',
        localizationsDelegates: const [
          TinyToolsLocalizations.delegate,
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
class _TinyToolsScrollBehavior extends ScrollBehavior {
  const _TinyToolsScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}
