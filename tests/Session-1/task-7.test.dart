import 'package:test/test.dart';

import 'task.dart';

void main() {
  group('Example tests', () {
    test(
        'Example test 1 @Input: "\nqueue.push(1);\nqueue.push(2);\nqueue.peek();"',
        () {
      MyQueue queue = MyQueue();

      queue.push(1);
      queue.push(2);
      expect(queue.peek(), 1);
    });
  });

  group('Main tests', () {
    test(
        'Some operations 1 @Input: "\nqueue.push(1);\nqueue.push(2);\nqueue.peek();\nqueue.pop();"',
        () {
      MyQueue queue = MyQueue();

      queue.push(1);
      queue.push(2);
      queue.peek();
      expect(queue.pop(), 1);
    });

    test(
        'Some operations 2 @Input: "\nqueue.push(1);\nqueue.push(2);\nqueue.peek();\nqueue.pop();\nqueue.pop();"',
        () {
      MyQueue queue = MyQueue();

      queue.push(1);
      queue.push(2);
      queue.peek();
      queue.pop();
      expect(queue.pop(), 2);
    });

    test(
        'Some operations 3 @Input: "\nqueue.push(1);\nqueue.push(2);\nqueue.peek();\nqueue.pop();\nqueue.empty();"',
        () {
      MyQueue queue = MyQueue();

      queue.push(1);
      queue.push(2);
      queue.peek();
      queue.pop();
      expect(queue.empty(), false);
    });

    test('Some operations 4 @Input: "\nqueue.empty();"', () {
      MyQueue queue = MyQueue();

      expect(queue.empty(), true);
    });

    test('Some operations 5 @Input: "\nqueue.peek();"', () {
      MyQueue queue = MyQueue();

      expect(queue.peek(), null);
    });

    test('Some operations 6 @Input: "\nqueue.peek()\nqueue.pop();"', () {
      MyQueue queue = MyQueue();

      queue.peek();
      expect(queue.pop(), null);
    });

    test(
        'Some operations 7 @Input: "\nqueue.push(1);\nqueue.push(2);\nqueue.push(3);\nqueue.pop();\nqueue.push(4);\nqueue.pop();\nqueue.pop();\nqueue.pop();\nqueue.empty();"',
        () {
      MyQueue queue = MyQueue();

      queue.push(1);
      queue.push(2);
      queue.push(3);
      queue.pop();
      queue.push(4);
      queue.pop();
      queue.pop();
      queue.pop();
      expect(queue.empty(), true);
    });

    test(
        'Some operations 8 @Input: "\nqueue.push(1);\nqueue.push(2);\nqueue.pop();\nqueue.empty();"',
        () {
      MyQueue queue = MyQueue();

      queue.push(1);
      queue.push(2);
      queue.pop();
      expect(queue.empty(), false);
    });

    test(
        'Some operations 9 @Input: "\nqueue.push(1);\nqueue.push(2);\nqueue.peek();\nqueue.pop();\nqueue.push(3);\nqueue.peek();"',
        () {
      MyQueue queue = MyQueue();

      queue.push(1);
      queue.push(2);
      queue.peek();
      queue.pop();
      queue.push(3);
      expect(queue.peek(), 2);
    });

    test(
        'Some operations 10 @Input: "\nqueue.push(1);\nqueue.push(2);\nqueue.pop();\nqueue.pop();\nqueue.push(3);\nqueue.push(4);\nqueue.peek();"',
        () {
      MyQueue queue = MyQueue();

      queue.push(1);
      queue.push(2);
      queue.pop();
      queue.pop();
      queue.push(3);
      queue.push(4);
      expect(queue.peek(), 3);
    });

    test(
        'Some operations 11 @Input: "\nqueue.push(1);\nqueue.push(2);\nqueue.push(3);\nqueue.pop();\nqueue.push(4);\nqueue.pop();\nqueue.pop();\nqueue.pop();\nqueue.push(5);\nqueue.peek();"',
        () {
      MyQueue queue = MyQueue();

      queue.push(1);
      queue.push(2);
      queue.push(3);
      queue.pop();
      queue.push(4);
      queue.pop();
      queue.pop();
      queue.pop();
      queue.push(5);
      expect(queue.peek(), 5);
    });

    test(
        'Some operations 12 @Input: "\nqueue.push(1);\nqueue.pop();\nqueue.empty();\nqueue.push(2);\nqueue.peek();\nqueue.pop();"',
        () {
      MyQueue queue = MyQueue();

      queue.push(1);
      queue.pop();
      expect(queue.empty(), true);
      queue.push(2);
      expect(queue.peek(), 2);
      expect(queue.pop(), 2);
    });

    test(
        'Some operations 13 @Input: "\nqueue.push(1);\nqueue.push(2);\nqueue.push(3);\nqueue.empty();\nqueue.push(4);\nqueue.peek();\nqueue.pop();"',
        () {
      MyQueue queue = MyQueue();

      queue.push(1);
      queue.push(2);
      queue.push(3);
      expect(queue.empty(), false);
      queue.push(4);
      expect(queue.peek(), 1);
      expect(queue.pop(), 1);
    });
  });
}
