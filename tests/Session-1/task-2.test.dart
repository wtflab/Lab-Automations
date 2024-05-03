import 'package:test/test.dart';

import 'task.dart';

void main() {
  group('Example tests', () {
    test('Example test 1', () {
      expect(findMissingNumber([3, 0, 7, 1, 2, 8, 4, 5]), equals(6));
    });

    test('Example test 2', () {
      expect(findMissingNumber([0, 1, 3]), equals(2));
    });
  });

  group('Main tests', () {
    test('Missing number with shuffled input - 1', () {
      expect(findMissingNumber([6, 1, 0, 2, 4, 3, 7]), equals(5));
    });

    test('Missing number with shuffled input - 2', () {
      expect(findMissingNumber([8, 5, 0, 6, 2, 3, 1, 4]), equals(7));
    });

    test('Missing number with shuffled input - 3', () {
      expect(findMissingNumber([3, 7, 1, 0, 6, 8, 5, 2, 4]), equals(9));
    });

    test('Missing number with shuffled input - 4', () {
      expect(findMissingNumber([1, 3, 7, 2, 4, 6, 5, 9, 0, 8]), equals(10));
    });

    test('Missing number with shuffled input - 5', () {
      expect(findMissingNumber([2, 6, 1, 0, 10, 3, 5, 9, 7, 4, 8]), equals(11));
    });

    test('Empty input list', () {
      expect(findMissingNumber([]), equals(0));
    });

    test('Missing number is 0', () {
      expect(findMissingNumber([1, 2, 3]), equals(0));
    });

    test('Missing number is the last element', () {
      expect(findMissingNumber([0, 1, 2, 3, 4, 5, 6, 7, 8]), equals(9));
    });

    test('Missing number is in the middle', () {
      expect(findMissingNumber([0, 1, 2, 4, 5, 6, 7, 8, 9]), equals(3));
    });

    test('Missing number with large input size', () {
      List<int> nums = List<int>.generate(1000000, (index) => index);
      nums.remove(999998);
      expect(findMissingNumber(nums), equals(999998));
    });
  });
}
