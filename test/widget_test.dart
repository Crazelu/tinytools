import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:tools/core/app/app.dart';
import 'package:tools/core/dialog/dialog_handler.dart';
import 'package:tools/core/navigation/navigation_bus.dart';
import 'package:tools/core/localization/app_localizations_en.dart';
import 'package:tools/pages.dart';

import 'mocks.mocks.dart';

void main() {
  setUpAll(
    () {
      GetIt.I.registerSingleton<DialogHandler>(
        MockDialogHandler(),
      );
      GetIt.I.registerSingleton<NavigationBus>(
        MockNavigationBus(),
      );
    },
  );
  testWidgets('TinyToolsApp test', (WidgetTester tester) async {
    when(GetIt.I<DialogHandler>().dialogKey).thenReturn(GlobalKey());

    await tester.pumpWidget(const TinyToolsApp());

    final locale = TinyToolsLocalizationsEn();

    expect(find.byType(HomePage), findsOneWidget);
    expect(find.text(locale.luckysTools), findsOneWidget);
    expect(find.text(locale.luckysToolsDescription), findsOneWidget);
  });
}
