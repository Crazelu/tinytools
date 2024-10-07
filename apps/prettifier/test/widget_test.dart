import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  const channel = OptionalMethodChannel('flutter/platform', JSONMethodCodec());
  TestWidgetsFlutterBinding.ensureInitialized();
  late Completer<String> completer;

  setUp(
    () {
      completer = Completer<String>();

      GetIt.I.registerSingleton<DialogHandler>(
        MockDialogHandler(),
      );
      GetIt.I.registerSingleton<NavigationBus>(
        MockNavigationBus(),
      );

      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        channel,
        (message) async {
          if (message.method == 'Clipboard.setData') {
            completer.complete(Map.from(message.arguments)['text']);
          }
          return null;
        },
      );
    },
  );

  tearDown(
    () {
      GetIt.I.reset();
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        channel,
        null,
      );
    },
  );

  testWidgets(
    'PrettifierApp test',
    (tester) async {
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
    },
  );

  testWidgets(
    'Verify that copy button is shown '
    'When a valid JSON is formatted',
    (tester) async {
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

      expect(find.widgetWithText(TextButton, locale.copy), findsOneWidget);
    },
  );

  testWidgets(
    'Given that a valid JSON is formatted, '
    'When Copy button is pressed, '
    'Verify that formatted JSON is copied to clipboard '
    'and button text is changed to Copied!',
    (tester) async {
      when(GetIt.I<DialogHandler>().dialogKey).thenReturn(GlobalKey());

      final testJSON = {
        "app": "PrettifierApp",
        "testing": true,
        "users": ["Lucky", "You Amazing Human"]
      };

      const encoder = JsonEncoder.withIndent('  ');

      await tester.pumpWidget(const PrettifierApp());

      final locale = PrettifierLocalizationsEn();

      expect(find.byType(HomePage), findsOneWidget);
      expect(find.text(locale.jsonPrettifier), findsOneWidget);
      expect(find.text(locale.enterJSON), findsOneWidget);

      await tester.enterText(find.byType(TextField), jsonEncode(testJSON));
      await tester.pump();

      final copyButton = find.widgetWithText(TextButton, locale.copy);
      await tester.tap(copyButton);
      await tester.pump();

      expect(completer.future, completion(encoder.convert(testJSON)));
      expect(find.widgetWithText(TextButton, locale.copied), findsOneWidget);
    },
  );
}
