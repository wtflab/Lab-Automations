import 'package:test/test.dart';

import 'dart:async';
import 'dart:isolate';

import 'task.dart';

void main() {
  group('Example tests', () {
    test('Example test 1 @Input: "[1, 2, 4], [1, 3, 4]"', () async {
      final result = await executeWithTimeout(
          mergeSortedLists,
          [
            [1, 2, 4],
            [1, 3, 4]
          ],
          Duration(milliseconds: 500));
      expect(result, [1, 1, 2, 3, 4, 4]);
    });

    test('Example test 2 @Input: "[0, 3, 8], [5, 6]"', () async {
      final result = await executeWithTimeout(
          mergeSortedLists,
          [
            [0, 3, 8],
            [5, 6]
          ],
          Duration(milliseconds: 500));
      expect(result, [0, 3, 5, 6, 8]);
    });
  });

  group('Main tests', () {
    test(
        'Merge two sorted lists with common elements @Input: "[1, 2, 4], [1, 3, 4]"',
        () async {
      final result = await executeWithTimeout(
          mergeSortedLists,
          [
            [1, 2, 4],
            [1, 3, 4]
          ],
          Duration(milliseconds: 500));
      expect(result, [1, 1, 2, 3, 4, 4]);
    });

    test(
        'Merge two sorted lists with non-overlapping elements @Input: "[0, 3, 8], [5, 6]"',
        () async {
      final result = await executeWithTimeout(
          mergeSortedLists,
          [
            [0, 3, 8],
            [5, 6]
          ],
          Duration(milliseconds: 500));
      expect(result, [0, 3, 5, 6, 8]);
    });

    test('Merge two empty lists @Input: "[], []"', () async {
      final result = await executeWithTimeout(
          mergeSortedLists, [<int>[], <int>[]], Duration(milliseconds: 500));
      expect(result, []);
    });

    test('Merge an empty list with a non-empty list @Input: "[1, 2, 3], []"',
        () async {
      final result = await executeWithTimeout(
          mergeSortedLists,
          [
            [1, 2, 3],
            <int>[]
          ],
          Duration(milliseconds: 500));
      expect(result, [1, 2, 3]);
    });

    test('Merge a non-empty list with an empty list @Input: "[], [4, 5, 6]"',
        () async {
      final result = await executeWithTimeout(
          mergeSortedLists,
          [
            <int>[],
            [4, 5, 6]
          ],
          Duration(milliseconds: 500));
      expect(result, [4, 5, 6]);
    });

    test(
        'Merge two sorted lists with alternating elements @Input: "[1, 3, 5], [2, 4, 6]"',
        () async {
      final result = await executeWithTimeout(
          mergeSortedLists,
          [
            [1, 3, 5],
            [2, 4, 6]
          ],
          Duration(milliseconds: 500));
      expect(result, [1, 2, 3, 4, 5, 6]);
    });

    test(
        'Merge two sorted lists with different lengths @Input: "[1, 3, 5, 7], [2, 4, 6]"',
        () async {
      final result = await executeWithTimeout(
          mergeSortedLists,
          [
            [1, 3, 5, 7],
            [2, 4, 6]
          ],
          Duration(milliseconds: 500));
      expect(result, [1, 2, 3, 4, 5, 6, 7]);
    });

    test(
        'Merge two sorted lists with duplicate elements @Input: "[1, 3, 5], [2, 4, 6, 8]"',
        () async {
      final result = await executeWithTimeout(
          mergeSortedLists,
          [
            [1, 3, 5],
            [2, 4, 6, 8]
          ],
          Duration(milliseconds: 500));
      expect(result, [1, 2, 3, 4, 5, 6, 8]);
    });

    test('Merge a single-element list with a list @Input: "[10], [5, 15]"',
        () async {
      final result = await executeWithTimeout(
          mergeSortedLists,
          [
            [10],
            [5, 15]
          ],
          Duration(milliseconds: 500));
      expect(result, [5, 10, 15]);
    });

    test(
        'Merge two sorted lists with repeated elements @Input: "[5, 10], [5, 10]"',
        () async {
      final result = await executeWithTimeout(
          mergeSortedLists,
          [
            [5, 10],
            [5, 10]
          ],
          Duration(milliseconds: 500));
      expect(result, [5, 5, 10, 10]);
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
