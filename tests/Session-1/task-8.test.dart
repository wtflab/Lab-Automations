import 'package:test/test.dart';

import 'task.dart';

void main() {
  group('Example tests', () {
    test('Rotate a 3x3 matrix clockwise', () {
      List<List<int>> matrix = [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9]
      ];

      rotateImage(matrix);

      expect(matrix, [
        [7, 4, 1],
        [8, 5, 2],
        [9, 6, 3]
      ]);
    });

    test('Rotate a 4x4 matrix clockwise', () {
      List<List<int>> matrix = [
        [5, 1, 9, 11],
        [2, 4, 8, 10],
        [13, 3, 6, 7],
        [15, 14, 12, 16]
      ];

      rotateImage(matrix);

      expect(matrix, [
        [15, 13, 2, 5],
        [14, 3, 4, 1],
        [12, 6, 8, 9],
        [16, 7, 10, 11]
      ]);
    });
  });

  group('Main tests', () {
    test('Rotate a 1x1 matrix clockwise', () {
      List<List<int>> matrix = [
        [9]
      ];

      rotateImage(matrix);

      expect(matrix, [
        [9]
      ]);
    });

    test('Rotate a 2x2 matrix clockwise', () {
      List<List<int>> matrix = [
        [1, 2],
        [3, 4]
      ];

      rotateImage(matrix);

      expect(matrix, [
        [3, 1],
        [4, 2]
      ]);
    });

    test('Rotate a 5x5 matrix clockwise', () {
      List<List<int>> matrix = [
        [1, 2, 3, 4, 5],
        [6, 7, 8, 9, 10],
        [11, 12, 13, 14, 15],
        [16, 17, 18, 19, 20],
        [21, 22, 23, 24, 25]
      ];

      rotateImage(matrix);

      expect(matrix, [
        [21, 16, 11, 6, 1],
        [22, 17, 12, 7, 2],
        [23, 18, 13, 8, 3],
        [24, 19, 14, 9, 4],
        [25, 20, 15, 10, 5]
      ]);
    });

    test('Rotate an empty matrix', () {
      List<List<int>> matrix = [];

      rotateImage(matrix);

      expect(matrix, []);
    });

    test('Rotate a 3x3 matrix with negative values', () {
      List<List<int>> matrix = [
        [-1, -2, -3],
        [-4, -5, -6],
        [-7, -8, -9]
      ];

      rotateImage(matrix);

      expect(matrix, [
        [-7, -4, -1],
        [-8, -5, -2],
        [-9, -6, -3]
      ]);
    });

    test('Rotate a 4x4 matrix with duplicate values', () {
      List<List<int>> matrix = [
        [1, 1, 2, 2],
        [3, 3, 4, 4],
        [5, 5, 6, 6],
        [7, 7, 8, 8]
      ];

      rotateImage(matrix);

      expect(matrix, [
        [7, 5, 3, 1],
        [7, 5, 3, 1],
        [8, 6, 4, 2],
        [8, 6, 4, 2]
      ]);
    });

    test('Rotate a 2x2 matrix with negative and positive values', () {
      List<List<int>> matrix = [
        [-1, 2],
        [3, -4]
      ];

      rotateImage(matrix);

      expect(matrix, [
        [3, -1],
        [-4, 2]
      ]);
    });

    test('Rotate a 1x1 matrix with negative value', () {
      List<List<int>> matrix = [
        [-9]
      ];

      rotateImage(matrix);

      expect(matrix, [
        [-9]
      ]);
    });

    test('Rotate a 5x5 matrix with all zeros', () {
      List<List<int>> matrix = [
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0]
      ];

      rotateImage(matrix);

      expect(matrix, [
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0]
      ]);
    });

    test('Rotate a 4x4 matrix with alternating values', () {
      List<List<int>> matrix = [
        [1, 2, 1, 2],
        [2, 1, 2, 1],
        [1, 2, 1, 2],
        [2, 1, 2, 1]
      ];

      rotateImage(matrix);

      expect(matrix, [
        [2, 1, 2, 1],
        [1, 2, 1, 2],
        [2, 1, 2, 1],
        [1, 2, 1, 2]
      ]);
    });
  });
}
