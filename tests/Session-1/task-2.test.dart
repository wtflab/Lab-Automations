import 'package:test/test.dart';

import 'dart:async';
import 'dart:isolate';

import 'task.dart';

void main() {
  group('Example tests', () {
    test('Example test 1', () async {
      final result = await executeWithTimeout(
          findMissingNumber,
          [
            [3, 0, 7, 1, 2, 8, 4, 5]
          ],
          Duration(milliseconds: 500));
      expect(result, equals(6));
    });

    test('Example test 2', () async {
      final result = await executeWithTimeout(
          findMissingNumber,
          [
            [0, 1, 3]
          ],
          Duration(milliseconds: 500));
      expect(result, equals(2));
    });
  });

  group('Main tests', () {
    test('Missing number with shuffled input - 1', () async {
      final result = await executeWithTimeout(
          findMissingNumber,
          [
            [6, 1, 0, 2, 4, 3, 7]
          ],
          Duration(milliseconds: 500));
      expect(result, equals(5));
    });

    test('Missing number with shuffled input - 2', () async {
      final result = await executeWithTimeout(
          findMissingNumber,
          [
            [8, 5, 0, 6, 2, 3, 1, 4]
          ],
          Duration(milliseconds: 500));
      expect(result, equals(7));
    });

    test('Missing number with shuffled input - 3', () async {
      final result = await executeWithTimeout(
          findMissingNumber,
          [
            [3, 7, 1, 0, 6, 8, 5, 2, 4]
          ],
          Duration(milliseconds: 500));
      expect(result, equals(9));
    });

    test('Missing number with shuffled input - 4', () async {
      final result = await executeWithTimeout(
          findMissingNumber,
          [
            [1, 3, 7, 2, 4, 6, 5, 9, 0, 8]
          ],
          Duration(milliseconds: 500));
      expect(result, equals(10));
    });

    test('Missing number with shuffled input - 5', () async {
      final result = await executeWithTimeout(
          findMissingNumber,
          [
            [2, 6, 1, 0, 10, 3, 5, 9, 7, 4, 8]
          ],
          Duration(milliseconds: 500));
      expect(result, equals(11));
    });

    test('Empty input list', () async {
      final result = await executeWithTimeout(
          findMissingNumber, [<int>[]], Duration(milliseconds: 500));
      expect(result, equals(0));
    });

    test('Missing number is 0', () async {
      final result = await executeWithTimeout(
          findMissingNumber,
          [
            [1, 2, 3]
          ],
          Duration(milliseconds: 500));
      expect(result, equals(0));
    });

    test('Missing number is the last element', () async {
      final result = await executeWithTimeout(
          findMissingNumber,
          [
            [0, 1, 2, 3, 4, 5, 6, 7, 8]
          ],
          Duration(milliseconds: 500));
      expect(result, equals(9));
    });

    test('Missing number is in the middle', () async {
      final result = await executeWithTimeout(
          findMissingNumber,
          [
            [0, 1, 2, 4, 5, 6, 7, 8, 9]
          ],
          Duration(milliseconds: 500));
      expect(result, equals(3));
    });

    test('Missing number with large input size', () async {
      List<int> nums = List<int>.generate(1000000, (index) => index);
      nums.remove(999998);
      final result = await executeWithTimeout(
          findMissingNumber, [nums], Duration(milliseconds: 500));
      expect(result, equals(999998));
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
