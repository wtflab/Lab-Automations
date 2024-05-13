import 'package:test/test.dart';

import 'dart:async';
import 'dart:isolate';

import 'task.dart';

void main() {
  group('Example tests', () {
    test('Example test 1 @Input: "What the Flutter"', () async {
      final result = await executeWithTimeout(
          firstUniqChar, ['What the Flutter'], Duration(milliseconds: 500));
      expect(result, 'W');
    });

    test('Example test 2 @Input: "Flutter Flutter"', () async {
      final result = await executeWithTimeout(
          firstUniqChar, ['Flutter Flutter'], Duration(milliseconds: 500));
      expect(result, ' ');
    });

    test('Example test 3 @Input: "Dart is great"', () async {
      final result = await executeWithTimeout(
          firstUniqChar, ['Dart is great'], Duration(milliseconds: 500));
      expect(result, 'D');
    });
  });

  group('Main tests', () {
    test(
        'Find first unique character at the beginning of the string @Input: "What the Flutter"',
        () async {
      final result = await executeWithTimeout(
          firstUniqChar, ['What the Flutter'], Duration(milliseconds: 500));
      expect(result, 'W');
    });

    test(
        'Find first unique character in the middle of the string @Input: "Flutter Flutter"',
        () async {
      final result = await executeWithTimeout(
          firstUniqChar, ['Flutter Flutter'], Duration(milliseconds: 500));
      expect(result, ' ');
    });

    test(
        'Find first unique character at the end of the string @Input: "Dart is great"',
        () async {
      final result = await executeWithTimeout(
          firstUniqChar, ['Dart is great'], Duration(milliseconds: 500));
      expect(result, 'D');
    });

    test(
        'Find first unique character in a string with all unique characters @Input: "abcdefg"',
        () async {
      final result = await executeWithTimeout(
          firstUniqChar, ['abcdefg'], Duration(milliseconds: 500));
      expect(result, 'a');
    });

    test('Find first unique character in an empty string @Input: ""', () async {
      final result = await executeWithTimeout(
          firstUniqChar, [''], Duration(milliseconds: 500));
      expect(result, '');
    });

    test(
        'Find first unique character in a string with all repeated characters @Input: "aaaaa"',
        () async {
      final result = await executeWithTimeout(
          firstUniqChar, ['aaaaa'], Duration(milliseconds: 500));
      expect(result, '');
    });

    test(
        'Find first unique character in a string with multiple unique characters @Input: "abc"',
        () async {
      final result = await executeWithTimeout(
          firstUniqChar, ['abc'], Duration(milliseconds: 500));
      expect(result, 'a');
    });

    test(
        'Find first unique character in a string with special characters @Input: "!@#\$%^&*()"',
        () async {
      final result = await executeWithTimeout(
          firstUniqChar, ['!@#\$%^&*()'], Duration(milliseconds: 500));
      expect(result, '!');
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
    return new TimeoutException('Function execution time more 500 ms');
  }
}

void computeFunction(List<dynamic> data) {
  final Function function = data[0];
  final List<dynamic> arguments = data[1];
  final SendPort sendPort = data[2];

  final result = Function.apply(function, arguments);
  sendPort.send(result);
}
