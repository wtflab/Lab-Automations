import 'package:test/test.dart';

import 'task-6.dart';

void main() {
  group('Example tests', () {
    test('Example test 1', () {
      expect(firstUniqChar('What the Flutter'), 'W');
    });

    test('Example test 2', () {
      expect(firstUniqChar('Flutter Flutter'), ' ');
    });

    test('Example test 3', () {
      expect(firstUniqChar('Dart is great'), 'D');
    });
  });

  group('Main tests', () {
    test('Find first unique character at the beginning of the string', () {
      expect(firstUniqChar('What the Flutter'), 'W');
    });

    test('Find first unique character in the middle of the string', () {
      expect(firstUniqChar('Flutter Flutter'), ' ');
    });

    test('Find first unique character at the end of the string', () {
      expect(firstUniqChar('Dart is great'), 'D');
    });

    test('Find first unique character in a string with all unique characters',
        () {
      expect(firstUniqChar('abcdefg'), 'a');
    });

    test('Find first unique character in an empty string', () {
      expect(firstUniqChar(''), '');
    });

    test('Find first unique character in a string with all repeated characters',
        () {
      expect(firstUniqChar('aaaaa'), '');
    });

    test(
        'Find first unique character in a string with multiple unique characters',
        () {
      expect(firstUniqChar('abc'), 'a');
    });

    test('Find first unique character in a string with special characters', () {
      expect(firstUniqChar('!@#\$%^&*()'), '!');
    });
  });
}
