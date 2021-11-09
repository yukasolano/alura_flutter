import 'package:alura_flutter/main.dart';
import 'package:alura_flutter/screens/contact/contact_form.dart';
import 'package:alura_flutter/screens/dashboard.dart';
import 'package:alura_flutter/screens/transfers_web/contact_to_transfer_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'matchers.dart';
import 'mocks.dart';

void main() {
  testWidgets('Should save a contact', (tester) async {
    final mock  = MockContactDao();
    await tester.pumpWidget(ByteBankApp(contactDao: mock));

    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    final transferMinicard = find.byWidgetPredicate((widget) =>
        findMiniCard(widget, 'Transfer', Icons.monetization_on));
    expect(transferMinicard, findsOneWidget);

    await tester.tap(transferMinicard);
    await tester.pumpAndSettle();

    final contactList = find.byType(ContactToTransferList);
    expect(contactList, findsOneWidget);

    final fabnewContact = find.widgetWithIcon(FloatingActionButton, Icons.add);
    expect(fabnewContact, findsOneWidget);

    await tester.tap(fabnewContact);
    await tester.pumpAndSettle();

    final contactForm = find.byType(ContactForm);
    expect(contactForm, findsOneWidget);

    final nameTextField = find.byWidgetPredicate((widget) {
      if(widget is TextField) {
        return widget.decoration?.labelText == 'Full name';
      }
      return false;
    });
    expect(nameTextField, findsOneWidget);
    await tester.enterText(nameTextField, 'Alex');

    final accountNumberTextField = find.byWidgetPredicate((widget) {
      if(widget is TextField) {
        return widget.decoration?.labelText == 'Account number';
      }
      return false;
    });
    expect(accountNumberTextField, findsOneWidget);
    await tester.enterText(accountNumberTextField, '1000');

    final createButton = find.widgetWithText(ElevatedButton, 'Create');
    expect(createButton, findsOneWidget);

    await tester.tap(createButton);
    await tester.pumpAndSettle();

    final contactListBack = find.byType(ContactToTransferList);
    expect(contactListBack, findsOneWidget);
  });
}
