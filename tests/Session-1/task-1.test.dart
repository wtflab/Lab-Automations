import 'package:test/test.dart';

import 'dart:async';
import 'dart:isolate';

import 'task.dart';

void main() {
  group('Example tests', () {
    test('Example test 1', () async {
      final result = await executeWithTimeout(
          reverseString, ['hello'], Duration(milliseconds: 1000));
      expect(result, equals('olleh'));
    });

    test('Example test 2', () async {
      final result = await executeWithTimeout(
          reverseString, ['Dart'], Duration(milliseconds: 1000));
      expect(result, equals('traD'));
    });
  });

  group('Main tests', () {
    test('Reversing a single character', () async {
      final result = await executeWithTimeout(
          reverseString, ['a'], Duration(milliseconds: 1000));
      expect(result, equals('a'));
    });

    test('Reversing an empty string', () async {
      final result = await executeWithTimeout(
          reverseString, [''], Duration(milliseconds: 1000));
      expect(result, equals(''));
    });

    test('Reversing a string of digits', () async {
      final result = await executeWithTimeout(
          reverseString, ['123456789'], Duration(milliseconds: 1000));
      expect(result, equals('987654321'));
    });

    test('Reversing a string with numbers', () async {
      final result = await executeWithTimeout(
          reverseString, ['12345'], Duration(milliseconds: 1000));
      expect(result, equals('54321'));
    });

    test('Reversing a string with mixed uppercase and lowercase characters',
        () async {
      final result = await executeWithTimeout(
          reverseString, ['AbCdEfG'], Duration(milliseconds: 1000));
      expect(result, equals('GfEdCbA'));
    });

    test('Reversing a string with punctuation marks', () async {
      final result = await executeWithTimeout(
          reverseString, ['Hello, World!'], Duration(milliseconds: 1000));
      expect(result, equals('!dlroW ,olleH'));
    });

    test('Reversing a string with whitespace', () async {
      final result = await executeWithTimeout(
          reverseString, ['Hello World'], Duration(milliseconds: 1000));
      expect(result, equals('dlroW olleH'));
    });

    test('Reversing a long string', () async {
      final result = await executeWithTimeout(reverseString,
          ['Lorem ipsum dolor sit amet'], Duration(milliseconds: 1000));
      expect(result, equals('tema tis rolod muspi meroL'));
    });

    test('Reversing a string with special characters', () async {
      final result = await executeWithTimeout(
          reverseString, ['@!#HelloWorld'], Duration(milliseconds: 1000));
      expect(result, equals('dlroWolleH#!@'));
    });

    test('Reversing a string with leading and trailing whitespaces', () async {
      final result = await executeWithTimeout(
          reverseString, ['   Hello, World!   '], Duration(milliseconds: 1000));
      expect(result, equals('   !dlroW ,olleH   '));
    });
  });
}

Future<dynamic> executeWithTimeout(
    Function function, List<dynamic> arguments, Duration timeout) async {
  final receivePort = ReceivePort();
  final isolate = await Isolate.spawn(
      computeFunction, [function, arguments, receivePort.sendPort]);

  final timer = Timer(timeout, () {
    isolate.kill(priority: Isolate.immediate);
    receivePort.close();
  });

  try {
    final result = await receivePort.first;
    timer.cancel();
    return result;
  } catch (error) {
    timer.cancel();
    return new TimeoutException('Function execution time more 1000 ms');
  }
}

void computeFunction(List<dynamic> data) {
  final Function function = data[0];
  final List<dynamic> arguments = data[1];
  final SendPort sendPort = data[2];

  final result = Function.apply(function, arguments);
  sendPort.send(result);
}
