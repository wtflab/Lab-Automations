import 'package:test/test.dart';

import 'task-1.dart';

void main() {
  group('Example tests', () {
    test('Example test 1', () {
      expect(reverseString('hello'), equals('olleh'));
    });

    test('Example test 2', () {
      expect(reverseString('Dart'), equals('traD'));
    });
  });

  group('Main tests', () {
    test('Reversing a single character', () {
      expect(reverseString('a'), equals('a'));
    });

    test('Reversing an empty string', () {
      expect(reverseString(''), equals(''));
    });

    test('Reversing a string of digits', () {
      expect(reverseString('123456789'), equals('987654321'));
    });

    test('Reversing a string with numbers', () {
      expect(reverseString('12345'), equals('54321'));
    });

    test('Reversing a string with mixed uppercase and lowercase characters',
        () {
      expect(reverseString('AbCdEfG'), equals('GfEdCbA'));
    });

    test('Reversing a string with punctuation marks', () {
      expect(reverseString('Hello, World!'), equals('!dlroW ,olleH'));
    });

    test('Reversing a string with whitespace', () {
      expect(reverseString('Hello World'), equals('dlroW olleH'));
    });

    test('Reversing a long string', () {
      expect(reverseString('Lorem ipsum dolor sit amet'),
          equals('tema tis rolod muspi meroL'));
    });

    test('Reversing a string with special characters', () {
      expect(reverseString('@!#HelloWorld'), equals('dlroWolleH#!@'));
    });

    test('Reversing a string with leading and trailing whitespaces', () {
      expect(
          reverseString('   Hello, World!   '), equals('   !dlroW ,olleH   '));
    });
  });
}
