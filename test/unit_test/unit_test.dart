import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Simple Math', () {
    test('addition', () {
      expect(1 + 1, 2);
    });

    test('subtraction', () {
      expect(1 - 1, 0);
    });
  });
}