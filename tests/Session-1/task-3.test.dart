import 'package:test/test.dart';

import 'dart:async';
import 'dart:isolate';

import 'task.dart';

void main() {
  group('Example tests', () {
    test('Example test 1 @Input: "()[]{}"', () async {
      final result = await executeWithTimeout(
          isValidParentheses, ['()[]{}'], Duration(milliseconds: 500));
      expect(result, isTrue);
    });

    test('Example test 2 @Input: "(]"', () async {
      final result = await executeWithTimeout(
          isValidParentheses, ['(]'], Duration(milliseconds: 500));
      expect(result, isFalse);
    });
  });

  group('Main tests', () {
    test('Valid parentheses - all brackets @Input: "()[]{}"', () async {
      final result = await executeWithTimeout(
          isValidParentheses, ['()[]{}'], Duration(milliseconds: 500));
      expect(result, isTrue);
    });

    test('Valid parentheses - nested brackets @Input: "([]{})"', () async {
      final result = await executeWithTimeout(
          isValidParentheses, ['([]{})'], Duration(milliseconds: 500));
      expect(result, isTrue);
    });

    test('Valid parentheses - single type of bracket @Input: "((((()))))"',
        () async {
      final result = await executeWithTimeout(
          isValidParentheses, ['((((()))))'], Duration(milliseconds: 500));
      expect(result, isTrue);
    });

    test('Invalid parentheses - mismatched brackets @Input: "([)]"', () async {
      final result = await executeWithTimeout(
          isValidParentheses, ['([)]'], Duration(milliseconds: 500));
      expect(result, isFalse);
    });

    test('Invalid parentheses - unclosed brackets @Input: "({}["', () async {
      final result = await executeWithTimeout(
          isValidParentheses, ['({}['], Duration(milliseconds: 500));
      expect(result, isFalse);
    });

    test('Invalid parentheses - extra closing bracket @Input: "({})]"',
        () async {
      final result = await executeWithTimeout(
          isValidParentheses, ['({})]'], Duration(milliseconds: 500));
      expect(result, isFalse);
    });

    test('Invalid parentheses - extra opening bracket @Input: "([{])"',
        () async {
      final result = await executeWithTimeout(
          isValidParentheses, ['([{])'], Duration(milliseconds: 500));
      expect(result, isFalse);
    });

    test('Valid parentheses - empty string @Input: ""', () async {
      final result = await executeWithTimeout(
          isValidParentheses, [''], Duration(milliseconds: 500));
      expect(result, isTrue);
    });

    test('Invalid parentheses - single opening bracket @Input: "("', () async {
      final result = await executeWithTimeout(
          isValidParentheses, ['('], Duration(milliseconds: 500));
      expect(result, isFalse);
    });

    test('Invalid parentheses - single closing bracket @Input: ")"', () async {
      final result = await executeWithTimeout(
          isValidParentheses, [')'], Duration(milliseconds: 500));
      expect(result, isFalse);
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
