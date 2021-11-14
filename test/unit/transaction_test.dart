import 'package:alura_flutter/models/contact.dart';
import 'package:alura_flutter/models/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Should return the value when create a transaction', () {
    final transaction = Transaction('1', 200, new Contact(0, 'John', 1234));
    expect(transaction.value, 200);
  });

  test('Should show error when create transaction with value less than zero', () {
    expect(() => Transaction('1', 0, new Contact(0, 'John', 1234)), throwsAssertionError);
  });
}
