import 'package:test/test.dart';

import 'task.dart';

void main() {
  group('Example tests', () {
    test('Example test 1 @Input: "USD, EUR, 100"', () async {
      double result = await convertCurrency('USD', 'EUR', 100);
      expect(result, isNotNull);
      expect(result, isPositive);
    });

    test('Example test 2 @Input: "GBP, INR, 50"', () async {
      double result = await convertCurrency('GBP', 'INR', 50);
      expect(result, isNotNull);
      expect(result, isPositive);
    });
  });

  group('Main tests', () {
    test('EUR to USD @Input: "EUR, USD, 200"', () async {
      double result = await convertCurrency('EUR', 'USD', 200);
      expect(result, isNotNull);
      expect(result, isPositive);
    });

    test('INR to GBP @Input: "INR, GBP, 500"', () async {
      double result = await convertCurrency('INR', 'GBP', 500);
      expect(result, isNotNull);
      expect(result, isPositive);
    });

    test('Zero amount @Input: "USD, EUR, 0"', () async {
      double result = await convertCurrency('USD', 'EUR', 0);
      expect(result, isZero);
    });

    test('Negative amount @Input: "USD, EUR, -100', () async {
      double result = await convertCurrency('USD', 'EUR', -100);
      expect(result, isNegative);
    });

    test('Same currency codes 1 @Input: "USD, USD, 100"', () async {
      double result = await convertCurrency('USD', 'USD', 100);
      expect(result, equals(100));
    });

    test('Same currency codes 2 @Input: "EUR, EUR, 50"', () async {
      double result = await convertCurrency('EUR', 'EUR', 50);
      expect(result, equals(50));
    });

    test('Same currency codes - Zero amount 1 @Input: "USD, USD, 0"', () async {
      double result = await convertCurrency('USD', 'USD', 0);
      expect(result, equals(0));
    });

    test('Same currency codes - Zero amount 2 @Input: "EUR, EUR, 0"', () async {
      double result = await convertCurrency('EUR', 'EUR', 0);
      expect(result, equals(0));
    });

    test('Large amount @Input: "USD, EUR, 1000000"', () async {
      double result = await convertCurrency('USD', 'EUR', 1000000);
      expect(result, isNotNull);
      expect(result, isPositive);
    });

    test('Small amount @Input: "USD, EUR, 0.01"', () async {
      double result = await convertCurrency('USD', 'EUR', 0.01);
      expect(result, isNotNull);
      expect(result, isPositive);
    });
  });
}
