import 'package:test/test.dart';

import 'task.dart';

void main() {
  group('Example tests', () {
    test('Example test 1 @Input: "()[]{}"', () async {
      final result = await isValidParentheses('()[]{}');
      expect(result, isTrue);
    });

    test('Example test 2 @Input: "(]"', () async {
      final result = await isValidParentheses('(]');
      expect(result, isFalse);
    });
  });

  group('Main tests', () {
    test('Valid parentheses - all brackets @Input: "()[]{}"', () async {
      final result = await isValidParentheses('()[]{}');
      expect(result, isTrue);
    });

    test('Valid parentheses - nested brackets @Input: "([]{})"', () async {
      final result = await isValidParentheses('([]{})');
      expect(result, isTrue);
    });

    test('Valid parentheses - single type of bracket @Input: "((((()))))"',
        () async {
      final result = await isValidParentheses('((((()))))');
      expect(result, isTrue);
    });

    test('Invalid parentheses - mismatched brackets @Input: "([)]"', () async {
      final result = await isValidParentheses('([)]');
      expect(result, isFalse);
    });

    test('Invalid parentheses - unclosed brackets @Input: "({}["', () async {
      final result = await isValidParentheses('({}[');
      expect(result, isFalse);
    });

    test('Invalid parentheses - extra closing bracket @Input: "({})]"',
        () async {
      final result = await isValidParentheses('({})]');
      expect(result, isFalse);
    });

    test('Invalid parentheses - extra opening bracket @Input: "([{])"',
        () async {
      final result = await isValidParentheses('([{])');
      expect(result, isFalse);
    });

    test('Valid parentheses - empty string @Input: ""', () async {
      final result = await isValidParentheses('');
      expect(result, isTrue);
    });

    test('Invalid parentheses - single opening bracket @Input: "("', () async {
      final result = await isValidParentheses('(');
      expect(result, isFalse);
    });

    test('Invalid parentheses - single closing bracket @Input: ")"', () async {
      final result = await isValidParentheses(')');
      expect(result, isFalse);
    });
  });
}
