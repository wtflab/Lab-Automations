import 'package:test/test.dart';

import 'task-5.dart';

void main() {
  group('Example tests', () {
    test('Example test 1', () {
      expect(binarySearch([1, 3, 5, 7, 9], 3), 1);
    });

    test('Example test 2', () {
      expect(binarySearch([2, 4, 6, 8, 10], 5), -1);
    });
  });

  group('Main tests', () {
    test('Find target element in the middle of the array', () {
      expect(binarySearch([1, 3, 5, 7, 9], 5), 2);
    });

    test('Find target element at the beginning of the array', () {
      expect(binarySearch([1, 3, 5, 7, 9], 1), 0);
    });

    test('Find target element at the end of the array', () {
      expect(binarySearch([1, 3, 5, 7, 9], 9), 4);
    });

    test('Find target element in an array with one element', () {
      expect(binarySearch([5], 5), 0);
    });

    test('Find target element in an empty array', () {
      expect(binarySearch([], 5), -1);
    });

    test('Find target element in an array with duplicate elements', () {
      expect(binarySearch([1, 3, 5, 5, 7, 9], 5), 2);
    });

    test('Find target element greater than any element in the array', () {
      expect(binarySearch([1, 3, 5, 7, 9], 10), -1);
    });

    test('Find target element smaller than any element in the array', () {
      expect(binarySearch([1, 3, 5, 7, 9], 0), -1);
    });

    test('Find target element between two elements in the array', () {
      expect(binarySearch([1, 3, 5, 7, 9], 4), -1);
    });

    test('Find target element in a large array', () {
      final input = List<int>.generate(1000000, (i) => i * 2);
      expect(binarySearch(input, 10000), 5000);
    });
  });
}
