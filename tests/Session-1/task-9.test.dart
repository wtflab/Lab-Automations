import 'package:test/test.dart';

import 'task.dart';

void main() {
  group('Example tests', () {
    test(
        'Example test 1 @Input: "[[1, 0, 1, 0, 0], [1, 0, 1, 1, 1], [1, 1, 1, 1, 1], [1, 0, 0, 1, 0]]"',
        () async {
      List<List<int>> matrix = [
        [1, 0, 1, 0, 0],
        [1, 0, 1, 1, 1],
        [1, 1, 1, 1, 1],
        [1, 0, 0, 1, 0]
      ];

      final result = await maximalRectangle(matrix);
      expect(result, 6);
    });

    test('Example test 2 @Input: "[[0, 1], [1, 0]]"', () async {
      List<List<int>> matrix = [
        [0, 1],
        [1, 0]
      ];
      final result = await maximalRectangle(matrix);
      expect(result, 1);
    });
  });

  group('Main tests', () {
    test('Empty Matrix @Input: "[]"', () async {
      List<List<int>> matrix = [];
      final result = await maximalRectangle(matrix);
      expect(result, 0);
    });

    test('Matrix with all zeros @Input: "[[0, 0, 0], [0, 0, 0], [0, 0, 0]]"',
        () async {
      List<List<int>> matrix = [
        [0, 0, 0],
        [0, 0, 0],
        [0, 0, 0]
      ];
      final result = await maximalRectangle(matrix);
      expect(result, 0);
    });

    test('Matrix with all ones @Input: "[[1, 1, 1], [1, 1, 1], [1, 1, 1]]"',
        () async {
      List<List<int>> matrix = [
        [1, 1, 1],
        [1, 1, 1],
        [1, 1, 1]
      ];
      final result = await maximalRectangle(matrix);
      expect(result, 9);
    });

    test('Matrix with single row @Input: "[[1, 1, 1, 0, 1]]"', () async {
      List<List<int>> matrix = [
        [1, 1, 1, 0, 1]
      ];
      final result = await maximalRectangle(matrix);
      expect(result, 3);
    });

    test('Matrix with single column @Input: "[[1], [1], [0], [1], [1]]"',
        () async {
      List<List<int>> matrix = [
        [1],
        [1],
        [0],
        [1],
        [1]
      ];
      final result = await maximalRectangle(matrix);
      expect(result, 2);
    });

    test(
        'Matrix with rectangular shape @Input: "[[1, 0, 1], [1, 1, 1], [1, 1, 1]]"',
        () async {
      List<List<int>> matrix = [
        [1, 0, 1],
        [1, 1, 1],
        [1, 1, 1]
      ];
      final result = await maximalRectangle(matrix);
      expect(result, 6);
    });

    test('Matrix with no 1\'s @Input: "[[0, 0], [0, 0]]"', () async {
      List<List<int>> matrix = [
        [0, 0],
        [0, 0]
      ];
      final result = await maximalRectangle(matrix);
      expect(result, 0);
    });

    test(
        'Matrix with alternating rows of 1\'s and 0\'s @Input: "[[1, 1, 1, 1], [0, 0, 0, 0], [1, 1, 1, 1], [0, 0, 0, 0]]"',
        () async {
      List<List<int>> matrix = [
        [1, 1, 1, 1],
        [0, 0, 0, 0],
        [1, 1, 1, 1],
        [0, 0, 0, 0]
      ];
      final result = await maximalRectangle(matrix);
      expect(result, 4);
    });

    test(
        'Matrix with alternating columns of 1\'s and 0\'s @Input: "[[1, 0, 1, 0], [1, 0, 1, 0], [1, 0, 1, 0], [1, 0, 1, 0]]"',
        () async {
      List<List<int>> matrix = [
        [1, 0, 1, 0],
        [1, 0, 1, 0],
        [1, 0, 1, 0],
        [1, 0, 1, 0]
      ];
      final result = await maximalRectangle(matrix);
      expect(result, 4);
    });

    test('Matrix with single cell @Input: "[[1]]"', () async {
      List<List<int>> matrix = [
        [1]
      ];
      final result = await maximalRectangle(matrix);
      expect(result, 1);
    });
  });
}
