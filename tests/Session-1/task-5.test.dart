import 'package:test/test.dart';

import 'task.dart';

void main() {
  group('Example tests', () {
    test('Example test 1 @Input: "[1, 3, 5, 7, 9], 3"', () async {
      final result = await binarySearch([1, 3, 5, 7, 9], 3);
      expect(result, 1);
    });

    test('Example test 2 @Input: "[2, 4, 6, 8, 10], 5"', () async {
      final result = await binarySearch([2, 4, 6, 8, 10], 5);
      expect(result, -1);
    });
  });

  group('Main tests', () {
    test(
        'Find target element in the middle of the array @Input: "[1, 3, 5, 7, 9], 5"',
        () async {
      final result = await binarySearch([1, 3, 5, 7, 9], 5);
      expect(result, 2);
    });

    test(
        'Find target element at the beginning of the array @Input: "[1, 3, 5, 7, 9], 1"',
        () async {
      final result = await binarySearch([1, 3, 5, 7, 9], 1);
      expect(result, 0);
    });

    test(
        'Find target element at the end of the array @Input: "[1, 3, 5, 7, 9], 9"',
        () async {
      final result = await binarySearch([1, 3, 5, 7, 9], 9);
      expect(result, 4);
    });

    test('Find target element in an array with one element @Input: "[5], 5"',
        () async {
      final result = await binarySearch([5], 5);
      expect(result, 0);
    });

    test('Find target element in an empty array @Input: "[], 5"', () async {
      final result = await binarySearch(<int>[], 5);
      expect(result, -1);
    });

    test(
        'Find target element in an array with duplicate elements @Input: "[1, 3, 5, 5, 7, 9], 5"',
        () async {
      final result = await binarySearch([1, 3, 5, 5, 7, 9], 5);
      expect(result, 2);
    });

    test(
        'Find target element greater than any element in the array @Input: "[1, 3, 5, 7, 9], 10"',
        () async {
      final result = await binarySearch([1, 3, 5, 7, 9], 10);
      expect(result, -1);
    });

    test(
        'Find target element smaller than any element in the array @Input: "[1, 3, 5, 7, 9], 0"',
        () async {
      final result = await binarySearch([1, 3, 5, 7, 9], 0);
      expect(result, -1);
    });

    test(
        'Find target element between two elements in the array @Input: "[1, 3, 5, 7, 9], 4"',
        () async {
      final result = await binarySearch([1, 3, 5, 7, 9], 4);
      expect(result, -1);
    });

    test(
        'Find target element in a large array @Input: "[0, 1, 2, 3, 4...999998, 999999], 10000"',
        () async {
      final input = List<int>.generate(1000000, (i) => i * 2);
      final result = await binarySearch(input, 10000);
      expect(result, 5000);
    });
  });
}
