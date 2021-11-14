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

import '../helpers/mocks.dart';
import 'actions.dart';

void main() {

  MockContactDao mockContactDao = MockContactDao();
  MockTransactionWebClient mockWebClient = MockTransactionWebClient();

  setUp(() async {
    mockContactDao = MockContactDao();
    mockWebClient = MockTransactionWebClient();
  });

  testWidgets('Should transfer to a contact', (tester) async {

    await tester.pumpWidget(ByteBankApp(
      contactDao: mockContactDao,
      transactionWebClient: mockWebClient,
    ));

    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    final alex = Contact(0, 'Alex', 1000);
    when(mockContactDao.findAll()).thenAnswer((realInvocation) async => [alex]);

    await clickOnTheTransferMinicard(tester);

    verify(mockContactDao.findAll()).called(1);

    final contactList = find.byType(ContactToTransferList);
    expect(contactList, findsOneWidget);

    await clickOnContactItem(tester, name: 'Alex', accountNumber: 1000);

    final transactionForm = find.byType(TransactionForm);
    expect(transactionForm, findsOneWidget);

    final nameText = find.text('Alex');
    expect(nameText, findsOneWidget);

    final accountNumberText = find.text('1000');
    expect(accountNumberText, findsOneWidget);

    await fillTextWithTextLabel(tester, text: '200', labelText: 'Value');
    await clickOnTheButtonWithText(tester, 'Transfer');

    final authDialog = find.byType(AuthDialog);
    expect(authDialog, findsOneWidget);

    await fillTextWithKey(tester, text: '1000', key: authDialogTextFieldPasswordKey );

    when(mockWebClient.save( Transaction('', 200, alex), '1000'))
        .thenAnswer((realInvocation) async {
      return Transaction('123', 200, alex);
    });

    final cancelButton = find.widgetWithText(ElevatedButton, 'Cancel');
    expect(cancelButton, findsOneWidget);
    await clickOnTheButtonWithText(tester, 'Confirm');

    final successDialog = find.byType(SuccessDialog);
    expect(successDialog, findsOneWidget);

    await clickOnTheButtonWithText(tester, 'Ok');

    final contactListBack = find.byType(ContactToTransferList);
    expect(contactListBack, findsOneWidget);
  });
}

