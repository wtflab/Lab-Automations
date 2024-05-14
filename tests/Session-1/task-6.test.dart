import 'package:test/test.dart';

import 'task.dart';

void main() {
  group('Example tests', () {
    test('Example test 1 @Input: "What the Flutter"', () async {
      final result = await firstUniqChar('What the Flutter');
      expect(result, 'W');
    });

    test('Example test 2 @Input: "Flutter Flutter"', () async {
      final result = await firstUniqChar('Flutter Flutter');
      expect(result, ' ');
    });

    test('Example test 3 @Input: "Dart is great"', () async {
      final result = await firstUniqChar('Dart is great');
      expect(result, 'D');
    });
  });

  group('Main tests', () {
    test(
        'Find first unique character at the beginning of the string @Input: "What the Flutter"',
        () async {
      final result = await firstUniqChar('What the Flutter');
      expect(result, 'W');
    });

    test(
        'Find first unique character in the middle of the string @Input: "Flutter Flutter"',
        () async {
      final result = await firstUniqChar('Flutter Flutter');
      expect(result, ' ');
    });

    test(
        'Find first unique character at the end of the string @Input: "Dart is great"',
        () async {
      final result = await firstUniqChar('Dart is great');
      expect(result, 'D');
    });

    test(
        'Find first unique character in a string with all unique characters @Input: "abcdefg"',
        () async {
      final result = await firstUniqChar('abcdefg');
      expect(result, 'a');
    });

    test('Find first unique character in an empty string @Input: ""', () async {
      final result = await firstUniqChar('');
      expect(result, '');
    });

    test(
        'Find first unique character in a string with all repeated characters @Input: "aaaaa"',
        () async {
      final result = await firstUniqChar('aaaaa');
      expect(result, '');
    });

    test(
        'Find first unique character in a string with multiple unique characters @Input: "abc"',
        () async {
      final result = await firstUniqChar('abc');
      expect(result, 'a');
    });

    test(
        'Find first unique character in a string with special characters @Input: "!@#\$%^&*()"',
        () async {
      final result = await firstUniqChar('!@#\$%^&*()');
      expect(result, '!');
    });
  });
}
