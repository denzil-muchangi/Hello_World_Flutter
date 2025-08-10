import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_world/root/widgets/body.dart';

void main() {
  testWidgets('Body displays text', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Body(),
        ),
      ),
    );

    expect(find.text('Hello'), findsOneWidget);
    expect(find.text(', Flutter'), findsOneWidget);
    expect(find.text(' !!!'), findsOneWidget);
  });
}