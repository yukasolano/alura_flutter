import 'package:alura_flutter/components/auth_dialog.dart';
import 'package:alura_flutter/components/response_dialog.dart';
import 'package:alura_flutter/main.dart';
import 'package:alura_flutter/models/contact.dart';
import 'package:alura_flutter/models/transaction.dart';
import 'package:alura_flutter/screens/dashboard.dart';
import 'package:alura_flutter/screens/transfers_web/contact_to_transfer_list.dart';
import 'package:alura_flutter/screens/transfers_web/transaction_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../helpers/matchers.dart';
import '../helpers/mocks.dart';
import 'actions.dart';

void main() {
  testWidgets('Should transfer to a contact', (tester) async {
    final mockContactDao = MockContactDao();
    final mockTransactionWebClient = MockTransactionWebClient();
    await tester.pumpWidget(ByteBankApp(
      contactDao: mockContactDao,
      transactionWebClient: mockTransactionWebClient,
    ));

    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    final alex = Contact(0, 'Alex', 1000);
    when(mockContactDao.findAll()).thenAnswer((realInvocation) async => [alex]);

    await clickOnTheTransferMinicard(tester);
    await tester.pumpAndSettle();

    verify(mockContactDao.findAll()).called(1);

    final contactList = find.byType(ContactToTransferList);
    expect(contactList, findsOneWidget);

    final contactItem = find.byWidgetPredicate((widget) {
      if (widget is ContactItem) {
        return widget.contact.name == 'Alex' &&
            widget.contact.accountNumber == 1000;
      }
      return false;
    });
    expect(contactItem, findsOneWidget);
    await tester.tap(contactItem);
    await tester.pumpAndSettle();

    final transactionForm = find.byType(TransactionForm);
    expect(transactionForm, findsOneWidget);

    final nameText = find.text('Alex');
    expect(nameText, findsOneWidget);

    final accountNumberText = find.text('1000');
    expect(accountNumberText, findsOneWidget);

    final valueLabel =
        find.byWidgetPredicate((widget) => findLabel(widget, 'Value'));
    expect(valueLabel, findsOneWidget);
    await tester.enterText(valueLabel, '200');
    await tester.pumpAndSettle();

    final transferButton = find.widgetWithText(ElevatedButton, 'Transfer');
    expect(transferButton, findsOneWidget);
    await tester.tap(transferButton);
    await tester.pumpAndSettle();

    final authDialog = find.byType(AuthDialog);
    expect(authDialog, findsOneWidget);

    final passwordField = find.byKey(authDialogTextFieldPasswordKey);
    expect(passwordField, findsOneWidget);
    await tester.enterText(passwordField, '1000');

    final cancelButton = find.widgetWithText(ElevatedButton, 'Cancel');
    expect(cancelButton, findsOneWidget);

    final confirmButton = find.widgetWithText(ElevatedButton, 'Confirm');
    expect(confirmButton, findsOneWidget);

    when(mockTransactionWebClient.save( Transaction('', 200, alex), '1000'))
        .thenAnswer((realInvocation) async {
          return Transaction('123', 200, alex);
        });
    await tester.tap(confirmButton);
    await tester.pumpAndSettle();

    final successDialog = find.byType(SuccessDialog);
    expect(successDialog, findsOneWidget);

    final okButton = find.widgetWithText(ElevatedButton, 'Ok');
    expect(okButton, findsOneWidget);
    await tester.tap(okButton);
    await tester.pumpAndSettle();

    final contactListBack = find.byType(ContactToTransferList);
    expect(contactListBack, findsOneWidget);
  });
}
