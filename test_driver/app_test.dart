import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Hello World App', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      driver.close();
    });

    test('verifies the text on the screen', () async {
      final textFinder = find.text('Hello, Flutter !!!');
      expect(await driver.getText(textFinder), 'Hello, Flutter !!!');
    });
  });
}