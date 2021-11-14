import 'package:alura_flutter/main.dart';
import 'package:alura_flutter/models/contact.dart';
import 'package:alura_flutter/screens/contact/contact_form.dart';
import 'package:alura_flutter/screens/dashboard.dart';
import 'package:alura_flutter/screens/transfers_web/contact_to_transfer_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../helpers/mocks.dart';
import 'actions.dart';

void main() {
  testWidgets('Should save a contact', (tester) async {
    final mock = MockContactDao();
    await tester.pumpWidget(ByteBankApp(contactDao: mock));

    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    await clickOnTheTransferMinicard(tester);
    await tester.pumpAndSettle();

    verify(mock.findAll()).called(1);

    final contactList = find.byType(ContactToTransferList);
    expect(contactList, findsOneWidget);

    final fabnewContact = find.widgetWithIcon(FloatingActionButton, Icons.add);
    expect(fabnewContact, findsOneWidget);

    await tester.tap(fabnewContact);
    await tester.pumpAndSettle();

    final contactForm = find.byType(ContactForm);
    expect(contactForm, findsOneWidget);

    final nameTextField =
        find.byWidgetPredicate((widget) => _isLabel(widget, 'Full name'));
    expect(nameTextField, findsOneWidget);
    await tester.enterText(nameTextField, 'Alex');

    final accountNumberTextField =
        find.byWidgetPredicate((widget) => _isLabel(widget, 'Account number'));
    expect(accountNumberTextField, findsOneWidget);
    await tester.enterText(accountNumberTextField, '1000');

    final createButton = find.widgetWithText(ElevatedButton, 'Create');
    expect(createButton, findsOneWidget);

    await tester.tap(createButton);
    await tester.pumpAndSettle();

    verify(mock.save(new Contact(0, 'Alex', 1000))).called(1);

    verify(mock.findAll()).called(1);
    final contactListBack = find.byType(ContactToTransferList);
    expect(contactListBack, findsOneWidget);
  });
}

bool _isLabel(Widget widget, String label) {
  if (widget is TextField) {
    return widget.decoration?.labelText == label;
  }
  return false;
}
