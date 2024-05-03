import 'package:test/test.dart';

import 'task.dart';

void main() {
  group('Example tests', () {
    test('Example test 1', () {
      expect(mergeSortedLists([1, 2, 4], [1, 3, 4]), [1, 1, 2, 3, 4, 4]);
    });

    test('Example test 2', () {
      expect(mergeSortedLists([0, 3, 8], [5, 6]), [0, 3, 5, 6, 8]);
    });
  });

  group('Main tests', () {
    test('Merge two sorted lists with common elements', () {
      expect(mergeSortedLists([1, 2, 4], [1, 3, 4]), [1, 1, 2, 3, 4, 4]);
    });

    test('Merge two sorted lists with non-overlapping elements', () {
      expect(mergeSortedLists([0, 3, 8], [5, 6]), [0, 3, 5, 6, 8]);
    });

    test('Merge two empty lists', () {
      expect(mergeSortedLists([], []), []);
    });

    test('Merge an empty list with a non-empty list', () {
      expect(mergeSortedLists([1, 2, 3], []), [1, 2, 3]);
    });

    test('Merge a non-empty list with an empty list', () {
      expect(mergeSortedLists([], [4, 5, 6]), [4, 5, 6]);
    });

    test('Merge two sorted lists with alternating elements', () {
      expect(mergeSortedLists([1, 3, 5], [2, 4, 6]), [1, 2, 3, 4, 5, 6]);
    });

    test('Merge two sorted lists with different lengths', () {
      expect(mergeSortedLists([1, 3, 5, 7], [2, 4, 6]), [1, 2, 3, 4, 5, 6, 7]);
    });

    test('Merge two sorted lists with duplicate elements', () {
      expect(mergeSortedLists([1, 3, 5], [2, 4, 6, 8]), [1, 2, 3, 4, 5, 6, 8]);
    });

    test('Merge a single-element list with a list', () {
      expect(mergeSortedLists([10], [5, 15]), [5, 10, 15]);
    });

    test('Merge two sorted lists with repeated elements', () {
      expect(mergeSortedLists([5, 10], [5, 10]), [5, 5, 10, 10]);
    });
  });
}
