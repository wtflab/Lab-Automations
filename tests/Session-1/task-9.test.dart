import 'package:test/test.dart';

import 'dart:async';
import 'dart:isolate';

import 'task.dart';

void main() {
  group('Example tests', () {
    test('Example test 1', () async {
      List<List<int>> matrix = [
        [1, 0, 1, 0, 0],
        [1, 0, 1, 1, 1],
        [1, 1, 1, 1, 1],
        [1, 0, 0, 1, 0]
      ];

      final result = await executeWithTimeout(
          maximalRectangle, [matrix], Duration(milliseconds: 500));
      expect(result, 6);
    });

    test('Example test 2', () async {
      List<List<int>> matrix = [
        [0, 1],
        [1, 0]
      ];
      final result = await executeWithTimeout(
          maximalRectangle, [matrix], Duration(milliseconds: 500));
      expect(result, 1);
    });
  });

  group('Main tests', () {
    test('Empty Matrix', () async {
      List<List<int>> matrix = [];
      final result = await executeWithTimeout(
          maximalRectangle, [matrix], Duration(milliseconds: 500));
      expect(result, 0);
    });

    test('Matrix with all zeros', () async {
      List<List<int>> matrix = [
        [0, 0, 0],
        [0, 0, 0],
        [0, 0, 0]
      ];
      final result = await executeWithTimeout(
          maximalRectangle, [matrix], Duration(milliseconds: 500));
      expect(result, 0);
    });

    test('Matrix with all ones', () async {
      List<List<int>> matrix = [
        [1, 1, 1],
        [1, 1, 1],
        [1, 1, 1]
      ];
      final result = await executeWithTimeout(
          maximalRectangle, [matrix], Duration(milliseconds: 500));
      expect(result, 9);
    });

    test('Matrix with single row', () async {
      List<List<int>> matrix = [
        [1, 1, 1, 0, 1]
      ];
      final result = await executeWithTimeout(
          maximalRectangle, [matrix], Duration(milliseconds: 500));
      expect(result, 3);
    });

    test('Matrix with single column', () async {
      List<List<int>> matrix = [
        [1],
        [1],
        [0],
        [1],
        [1]
      ];
      final result = await executeWithTimeout(
          maximalRectangle, [matrix], Duration(milliseconds: 500));
      expect(result, 2);
    });

    test('Matrix with rectangular shape', () async {
      List<List<int>> matrix = [
        [1, 0, 1],
        [1, 1, 1],
        [1, 1, 1]
      ];
      final result = await executeWithTimeout(
          maximalRectangle, [matrix], Duration(milliseconds: 500));
      expect(result, 6);
    });

    test('Matrix with no 1\'s', () async {
      List<List<int>> matrix = [
        [0, 0],
        [0, 0]
      ];
      final result = await executeWithTimeout(
          maximalRectangle, [matrix], Duration(milliseconds: 500));
      expect(result, 0);
    });

    test('Matrix with alternating rows of 1\'s and 0\'s', () async {
      List<List<int>> matrix = [
        [1, 1, 1, 1],
        [0, 0, 0, 0],
        [1, 1, 1, 1],
        [0, 0, 0, 0]
      ];
      final result = await executeWithTimeout(
          maximalRectangle, [matrix], Duration(milliseconds: 500));
      expect(result, 4);
    });

    test('Matrix with alternating columns of 1\'s and 0\'s', () async {
      List<List<int>> matrix = [
        [1, 0, 1, 0],
        [1, 0, 1, 0],
        [1, 0, 1, 0],
        [1, 0, 1, 0]
      ];
      final result = await executeWithTimeout(
          maximalRectangle, [matrix], Duration(milliseconds: 500));
      expect(result, 4);
    });

    test('Matrix with single cell', () async {
      List<List<int>> matrix = [
        [1]
      ];
      final result = await executeWithTimeout(
          maximalRectangle, [matrix], Duration(milliseconds: 500));
      expect(result, 1);
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
