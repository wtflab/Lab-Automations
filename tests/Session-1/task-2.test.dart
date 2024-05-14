import 'package:test/test.dart';

import 'task.dart';

void main() {
  group('Example tests', () {
    test('Example test 1 @Input: "[3, 0, 7, 1, 2, 8, 4, 5]"', () async {
      final result = await findMissingNumber([3, 0, 7, 1, 2, 8, 4, 5]);
      expect(result, equals(6));
    });

    test('Example test 2 @Input: "[0, 1, 3]"', () async {
      final result = await findMissingNumber([0, 1, 3]);
      expect(result, equals(2));
    });
  });

  group('Main tests', () {
    test(
        'Missing number with shuffled input - 1 @Input: "[6, 1, 0, 2, 4, 3, 7]"',
        () async {
      final result = await findMissingNumber([6, 1, 0, 2, 4, 3, 7]);
      expect(result, equals(5));
    });

    test(
        'Missing number with shuffled input - 2 @Input: "[8, 5, 0, 6, 2, 3, 1, 4]"',
        () async {
      final result = await findMissingNumber([8, 5, 0, 6, 2, 3, 1, 4]);
      expect(result, equals(7));
    });

    test(
        'Missing number with shuffled input - 3 @Input: "[3, 7, 1, 0, 6, 8, 5, 2, 4]"',
        () async {
      final result = await findMissingNumber([3, 7, 1, 0, 6, 8, 5, 2, 4]);
      expect(result, equals(9));
    });

    test(
        'Missing number with shuffled input - 4 @Input: "[1, 3, 7, 2, 4, 6, 5, 9, 0, 8]"',
        () async {
      final result = await findMissingNumber([1, 3, 7, 2, 4, 6, 5, 9, 0, 8]);
      expect(result, equals(10));
    });

    test(
        'Missing number with shuffled input - 5 @Input: "[2, 6, 1, 0, 10, 3, 5, 9, 7, 4, 8]"',
        () async {
      final result =
          await findMissingNumber([2, 6, 1, 0, 10, 3, 5, 9, 7, 4, 8]);
      expect(result, equals(11));
    });

    test('Empty input list @Input: "[]"', () async {
      final result = await findMissingNumber(<int>[]);
      expect(result, equals(0));
    });

    test('Missing number is 0 @Input: "[1, 2, 3]"', () async {
      final result = await findMissingNumber([1, 2, 3]);
      expect(result, equals(0));
    });

    test(
        'Missing number is the last element @Input: "[0, 1, 2, 3, 4, 5, 6, 7, 8]"',
        () async {
      final result = await findMissingNumber([0, 1, 2, 3, 4, 5, 6, 7, 8]);
      expect(result, equals(9));
    });

    test(
        'Missing number is in the middle @Input: "[0, 1, 2, 4, 5, 6, 7, 8, 9]"',
        () async {
      final result = await findMissingNumber([0, 1, 2, 4, 5, 6, 7, 8, 9]);
      expect(result, equals(3));
    });

    test(
        'Missing number with large input size @Input: "[0, 1, 2, 3, 4...999997, 999999]"',
        () async {
      List<int> nums = List<int>.generate(1000000, (index) => index);
      nums.remove(999998);
      final result = await findMissingNumber(nums);
      expect(result, equals(999998));
    });
  });
}
