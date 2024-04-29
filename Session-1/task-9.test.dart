import 'package:test/test.dart';

import 'task-9.dart';

void main() {
  group('Example tests', () {
    test('Example test 1', () {
      List<List<int>> matrix = [
        [1, 0, 1, 0, 0],
        [1, 0, 1, 1, 1],
        [1, 1, 1, 1, 1],
        [1, 0, 0, 1, 0]
      ];
      int? result = maximalRectangle(matrix);
      expect(result, 6);
    });

    test('Example test 2', () {
      List<List<int>> matrix = [
        [0, 1],
        [1, 0]
      ];
      int? result = maximalRectangle(matrix);
      expect(result, 1);
    });
  });

  group('Main tests', () {
    test('Empty Matrix', () {
      List<List<int>> matrix = [];
      int? result = maximalRectangle(matrix);
      expect(result, 0);
    });

    test('Matrix with all zeros', () {
      List<List<int>> matrix = [
        [0, 0, 0],
        [0, 0, 0],
        [0, 0, 0]
      ];
      int? result = maximalRectangle(matrix);
      expect(result, 0);
    });

    test('Matrix with all ones', () {
      List<List<int>> matrix = [
        [1, 1, 1],
        [1, 1, 1],
        [1, 1, 1]
      ];
      int? result = maximalRectangle(matrix);
      expect(result, 9);
    });

    test('Matrix with single row', () {
      List<List<int>> matrix = [
        [1, 1, 1, 0, 1]
      ];
      int? result = maximalRectangle(matrix);
      expect(result, 3);
    });

    test('Matrix with single column', () {
      List<List<int>> matrix = [
        [1],
        [1],
        [0],
        [1],
        [1]
      ];
      int? result = maximalRectangle(matrix);
      expect(result, 2);
    });

    test('Matrix with rectangular shape', () {
      List<List<int>> matrix = [
        [1, 0, 1],
        [1, 1, 1],
        [1, 1, 1]
      ];
      int? result = maximalRectangle(matrix);
      expect(result, 6);
    });

    test('Matrix with no 1\'s', () {
      List<List<int>> matrix = [
        [0, 0],
        [0, 0]
      ];
      int? result = maximalRectangle(matrix);
      expect(result, 0);
    });

    test('Matrix with alternating rows of 1\'s and 0\'s', () {
      List<List<int>> matrix = [
        [1, 1, 1, 1],
        [0, 0, 0, 0],
        [1, 1, 1, 1],
        [0, 0, 0, 0]
      ];
      int? result = maximalRectangle(matrix);
      expect(result, 4);
    });

    test('Matrix with alternating columns of 1\'s and 0\'s', () {
      List<List<int>> matrix = [
        [1, 0, 1, 0],
        [1, 0, 1, 0],
        [1, 0, 1, 0],
        [1, 0, 1, 0]
      ];
      int? result = maximalRectangle(matrix);
      expect(result, 4);
    });

    test('Matrix with single cell', () {
      List<List<int>> matrix = [
        [1]
      ];
      int? result = maximalRectangle(matrix);
      expect(result, 1);
    });
  });
}
