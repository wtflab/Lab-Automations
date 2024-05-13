import 'package:test/test.dart';

import 'dart:async';
import 'dart:isolate';

import 'task.dart';

void main() {
  group('Example tests', () {
    test('Example test 1 @Input: "[1, 3, 5, 7, 9], 3"', () async {
      final result = await executeWithTimeout(
          binarySearch,
          [
            [1, 3, 5, 7, 9],
            3
          ],
          Duration(milliseconds: 500));
      expect(result, 1);
    });

    test('Example test 2 @Input: "[2, 4, 6, 8, 10], 5"', () async {
      final result = await executeWithTimeout(
          binarySearch,
          [
            [2, 4, 6, 8, 10],
            5
          ],
          Duration(milliseconds: 500));
      expect(result, -1);
    });
  });

  group('Main tests', () {
    test(
        'Find target element in the middle of the array @Input: "[1, 3, 5, 7, 9], 5"',
        () async {
      final result = await executeWithTimeout(
          binarySearch,
          [
            [1, 3, 5, 7, 9],
            5
          ],
          Duration(milliseconds: 500));
      expect(result, 2);
    });

    test(
        'Find target element at the beginning of the array @Input: "[1, 3, 5, 7, 9], 1"',
        () async {
      final result = await executeWithTimeout(
          binarySearch,
          [
            [1, 3, 5, 7, 9],
            1
          ],
          Duration(milliseconds: 500));
      expect(result, 0);
    });

    test(
        'Find target element at the end of the array @Input: "[1, 3, 5, 7, 9], 9"',
        () async {
      final result = await executeWithTimeout(
          binarySearch,
          [
            [1, 3, 5, 7, 9],
            9
          ],
          Duration(milliseconds: 500));
      expect(result, 4);
    });

    test('Find target element in an array with one element @Input: "[5], 5"',
        () async {
      final result = await executeWithTimeout(
          binarySearch,
          [
            [5],
            5
          ],
          Duration(milliseconds: 500));
      expect(result, 0);
    });

    test('Find target element in an empty array @Input: "[], 5"', () async {
      final result = await executeWithTimeout(
          binarySearch, [<int>[], 5], Duration(milliseconds: 500));
      expect(result, -1);
    });

    test(
        'Find target element in an array with duplicate elements @Input: "[1, 3, 5, 5, 7, 9], 5"',
        () async {
      final result = await executeWithTimeout(
          binarySearch,
          [
            [1, 3, 5, 5, 7, 9],
            5
          ],
          Duration(milliseconds: 500));
      expect(result, 2);
    });

    test(
        'Find target element greater than any element in the array @Input: "[1, 3, 5, 7, 9], 10"',
        () async {
      final result = await executeWithTimeout(
          binarySearch,
          [
            [1, 3, 5, 7, 9],
            10
          ],
          Duration(milliseconds: 500));
      expect(result, -1);
    });

    test(
        'Find target element smaller than any element in the array @Input: "[1, 3, 5, 7, 9], 0"',
        () async {
      final result = await executeWithTimeout(
          binarySearch,
          [
            [1, 3, 5, 7, 9],
            0
          ],
          Duration(milliseconds: 500));
      expect(result, -1);
    });

    test(
        'Find target element between two elements in the array @Input: "[1, 3, 5, 7, 9], 4"',
        () async {
      final result = await executeWithTimeout(
          binarySearch,
          [
            [1, 3, 5, 7, 9],
            4
          ],
          Duration(milliseconds: 500));
      expect(result, -1);
    });

    test(
        'Find target element in a large array @Input: "[0,1,2,3,4...999998,999999], 10000"',
        () async {
      final input = List<int>.generate(1000000, (i) => i * 2);
      final result = await executeWithTimeout(
          binarySearch, [input, 10000], Duration(milliseconds: 500));
      expect(result, 5000);
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
