import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/matchers.dart';

Future<void> clickOnTheTransferMinicard(WidgetTester tester) async {
  final transferMinicard = find.byWidgetPredicate(
      (widget) => findMiniCard(widget, 'Transfer', Icons.monetization_on));
  expect(transferMinicard, findsOneWidget);

  return tester.tap(transferMinicard);
}
