import 'package:flutter_test/flutter_test.dart';
import 'package:tiny_rsa_tool/main.dart';

void main() {
  testWidgets('Tiny RSA Tool test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Tiny RSA Tool'), findsOneWidget);
  });
}
