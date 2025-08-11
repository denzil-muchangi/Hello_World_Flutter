import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:hello_world/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Scrolling Test', () {
    testWidgets('scroll down and up', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Scroll down.
      await tester.fling(find.byType(ListView), const Offset(0, -200), 3000);
      await tester.pumpAndSettle();

      // Scroll up.
      await tester.fling(find.byType(ListView), const Offset(0, 200), 3000);
      await tester.pumpAndSettle();
    });
  });
}