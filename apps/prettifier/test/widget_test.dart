import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:prettifier/core/app/app.dart';
import 'package:prettifier/core/dialog/dialog_handler.dart';
import 'package:prettifier/core/navigation/navigation_bus.dart';
import 'package:prettifier/core/localization/app_localizations_en.dart';
import 'package:prettifier/pages.dart';

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
  testWidgets('PrettifierApp test', (WidgetTester tester) async {
    when(GetIt.I<DialogHandler>().dialogKey).thenReturn(GlobalKey());

    final testJSON = {
      "app": "PrettifierApp",
      "testing": true,
      "users": ["Lucky", "You Amazing Human"]
    };

    await tester.pumpWidget(const PrettifierApp());

    final locale = PrettifierLocalizationsEn();

    expect(find.byType(HomePage), findsOneWidget);
    expect(find.text(locale.jsonPrettifier), findsOneWidget);
    expect(find.text(locale.enterJSON), findsOneWidget);

    await tester.enterText(find.byType(TextField), jsonEncode(testJSON));
    await tester.pump();

    const encoder = JsonEncoder.withIndent('  ');
    expect(find.text(encoder.convert(testJSON)), findsOneWidget);
  });
}
