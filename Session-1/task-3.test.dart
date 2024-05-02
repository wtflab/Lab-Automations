import 'package:test/test.dart';

import 'task-3.dart';

void main() {
  group('Example tests', () {
    test('Example test 1', () {
      expect(isValidParentheses('()[]{}'), isTrue);
    });

    test('Example test 2', () {
      expect(isValidParentheses('(]'), isFalse);
    });
  });

  group('Main tests', () {
    test('Valid parentheses - all brackets', () {
      expect(isValidParentheses('()[]{}'), isTrue);
    });

    test('Valid parentheses - nested brackets', () {
      expect(isValidParentheses('([]{})'), isTrue);
    });

    test('Valid parentheses - single type of bracket', () {
      expect(isValidParentheses('((((()))))'), isTrue);
    });

    test('Invalid parentheses - mismatched brackets', () {
      expect(isValidParentheses('([)]'), isFalse);
    });

    test('Invalid parentheses - unclosed brackets', () {
      expect(isValidParentheses('({}['), isFalse);
    });

    test('Invalid parentheses - extra closing bracket', () {
      expect(isValidParentheses('({})]'), isFalse);
    });

    test('Invalid parentheses - extra opening bracket', () {
      expect(isValidParentheses('([{])'), isFalse);
    });

    test('Valid parentheses - empty string', () {
      expect(isValidParentheses(''), isTrue);
    });

    test('Invalid parentheses - single opening bracket', () {
      expect(isValidParentheses('('), isFalse);
    });

    test('Invalid parentheses - single closing bracket', () {
      expect(isValidParentheses(')'), isFalse);
    });
  });
}
