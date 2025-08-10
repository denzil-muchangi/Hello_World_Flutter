import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_world/root/widgets/app_bar.dart';

void main() {
  testWidgets('CustomAppBar displays title', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          appBar: CustomAppBar(),
        ),
      ),
    );

    expect(find.text('Hello World'), findsOneWidget);
  });
}