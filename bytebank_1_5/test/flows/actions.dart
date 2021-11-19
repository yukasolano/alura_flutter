
import 'package:alura_flutter/screens/transfers_web/contact_to_transfer_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/matchers.dart';

Future<void> clickOnTheTransferMinicard(WidgetTester tester) async {
  final transferMinicard = find.byWidgetPredicate(
          (widget) => findMiniCard(widget, 'Transfer', Icons.monetization_on));
  expect(transferMinicard, findsOneWidget);

  await tester.tap(transferMinicard);
  await tester.pumpAndSettle();
}

Future<void> clickOnTheFabNew(WidgetTester tester) async {
  final fabnewContact = find.widgetWithIcon(FloatingActionButton, Icons.add);
  expect(fabnewContact, findsOneWidget);

  await tester.tap(fabnewContact);
  await tester.pumpAndSettle();
}

Future<void> clickOnTheButtonWithText(WidgetTester tester, String text) async {
  final createButton = find.widgetWithText(ElevatedButton, text);
  expect(createButton, findsOneWidget);

  await tester.tap(createButton);
  await tester.pumpAndSettle();
}

Future<void> fillTextWithTextLabel(WidgetTester tester, { required String text, required String labelText}) async {
  final nameTextField =
  find.byWidgetPredicate((widget) => findLabel(widget, labelText));
  expect(nameTextField, findsOneWidget);
  await tester.enterText(nameTextField, text);
}

Future<void> fillTextWithKey(WidgetTester tester,  {required String text, required Key key}) async {
  final passwordField = find.byKey(key);
  expect(passwordField, findsOneWidget);
  await tester.enterText(passwordField, text);
}

Future<void> clickOnContactItem(WidgetTester tester, {required String name, required int accountNumber}) async {
  final contactItem = find.byWidgetPredicate((widget) {
    if (widget is ContactItem) {
      return widget.contact.name == name &&
          widget.contact.accountNumber == accountNumber;
    }
    return false;
  });
  expect(contactItem, findsOneWidget);
  await tester.tap(contactItem);
  await tester.pumpAndSettle();
}
