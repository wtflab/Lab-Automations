import 'package:test/test.dart';

import 'task.dart';

void main() {
  group('Example tests', () {
    test('Example test 1 @Input: "hello"', () async {
      final result = reverseString('hello');
      expect(result, equals('olleh'));
    });

    test('Example test 2 @Input: "Dart"', () async {
      final result = reverseString('Dart');
      expect(result, equals('traD'));
    });
  });

  group('Main tests', () {
    test('Reversing a single character @Input: "a"', () async {
      final result = reverseString('a');
      expect(result, equals('a'));
    });

    test('Reversing an empty string @Input: ""', () async {
      final result = reverseString('');
      expect(result, equals(''));
    });

    test('Reversing a string of digits @Input: "123456789"', () async {
      final result = reverseString('123456789');
      expect(result, equals('987654321'));
    });

    test('Reversing a string with numbers @Input: "12345"', () async {
      final result = reverseString('54321');
      expect(result, equals('12345'));
    });

    test(
        'Reversing a string with mixed uppercase and lowercase characters @Input: "AbCdEfG"',
        () async {
      final result = reverseString('AbCdEfG');
      expect(result, equals('GfEdCbA'));
    });

    test('Reversing a string with punctuation marks @Input: "Hello, World!"',
        () async {
      final result = reverseString('Hello, World!');
      expect(result, equals('!dlroW ,olleH'));
    });

    test('Reversing a string with whitespace @Input: "Hello World"', () async {
      final result = reverseString('Hello World');
      expect(result, equals('dlroW olleH'));
    });

    test('Reversing a long string @Input: "Lorem ipsum dolor sit amet"',
        () async {
      final result = reverseString('Lorem ipsum dolor sit amet');
      expect(result, equals('tema tis rolod muspi meroL'));
    });

    test('Reversing a string with special characters @Input: "@!#HelloWorld"',
        () async {
      final result = reverseString('@!#HelloWorld');
      expect(result, equals('dlroWolleH#!@'));
    });

    test(
        'Reversing a string with leading and trailing whitespaces @Input: "   Hello, World!   "',
        () async {
      final result = reverseString('   Hello, World!   ');
      expect(result, equals('   !dlroW ,olleH   '));
    });
  });
}
