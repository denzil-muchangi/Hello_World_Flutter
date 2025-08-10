import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_world/root/app.dart';

void main() {
  testWidgets('Finds a widget by type', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(RichText), findsOneWidget);
  });
}