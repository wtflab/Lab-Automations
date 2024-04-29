import 'package:test/test.dart';

import 'task-7.dart';

void main() {
  group('Example tests', () {
    test('Example test 1', () {
      MyQueue queue = MyQueue();

      queue.push(1);
      queue.push(2);
      expect(queue.peek(), 1);
      expect(queue.pop(), 1);
      expect(queue.empty(), false);
    });
  });

  group('Main tests', () {
    test('Push, peek, and pop operations on the queue', () {
      MyQueue queue = MyQueue();

      queue.push(1);
      queue.push(2);
      expect(queue.peek(), 1);
      expect(queue.pop(), 1);
      expect(queue.empty(), false);
    });

    test('Empty queue', () {
      MyQueue queue = MyQueue();

      expect(queue.empty(), true);
    });

    test('Push and pop operations on the queue with multiple elements', () {
      MyQueue queue = MyQueue();

      queue.push(1);
      queue.push(2);
      queue.push(3);
      expect(queue.pop(), 1);
      queue.push(4);
      expect(queue.pop(), 2);
      expect(queue.pop(), 3);
      expect(queue.pop(), 4);
      expect(queue.empty(), true);
    });

    test('Peek and pop operations on an empty queue', () {
      MyQueue queue = MyQueue();

      expect(queue.peek(), null);
      expect(queue.pop(), null);
    });

    test('Push and pop operations on an empty queue', () {
      MyQueue queue = MyQueue();

      queue.push(1);
      expect(queue.pop(), 1);
      expect(queue.empty(), true);
    });

    test('Push and peek operations on a non-empty queue 1', () {
      MyQueue queue = MyQueue();

      queue.push(1);
      queue.push(2);
      expect(queue.peek(), 1);
      queue.push(3);
      expect(queue.peek(), 1);
      expect(queue.empty(), false);
    });

    test('Push and peek operations on a non-empty queue 2', () {
      MyQueue queue = MyQueue();

      queue.push(10);
      queue.push(20);
      queue.push(30);

      expect(queue.peek(), equals(10));
      expect(queue.pop(), equals(10));
      expect(queue.peek(), equals(20));
      expect(queue.pop(), equals(20));
      expect(queue.empty(), isFalse);
    });

    test('Push and pop operations on a non-empty queue', () {
      MyQueue queue = MyQueue();

      queue.push(1);
      queue.push(2);
      queue.push(3);

      expect(queue.pop(), equals(1));
      expect(queue.pop(), equals(2));
      expect(queue.peek(), equals(3));
      expect(queue.pop(), equals(3));
      expect(queue.empty(), isTrue);
    });

    test('Pop operations on a queue with a single element', () {
      MyQueue queue = MyQueue();

      queue.push(1);
      expect(queue.pop(), 1);
      expect(queue.empty(), true);
      expect(queue.pop(), null);
    });

    test('Empty queue with multiple push and pop operations', () {
      MyQueue queue = MyQueue();

      queue.push(1);
      queue.push(2);
      queue.pop();
      queue.push(3);
      queue.pop();
      queue.pop();
      expect(queue.empty(), true);
      expect(queue.pop(), null);
    });
  });
}
