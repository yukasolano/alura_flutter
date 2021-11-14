import 'package:alura_flutter/components/auth_dialog.dart';
import 'package:alura_flutter/main.dart';
import 'package:alura_flutter/models/contact.dart';
import 'package:alura_flutter/screens/contact/contact_form.dart';
import 'package:alura_flutter/screens/dashboard.dart';
import 'package:alura_flutter/screens/transfers_web/contact_to_transfer_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
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

  testWidgets('Should save a contact', (tester) async {

    await tester.pumpWidget(ByteBankApp(
      contactDao: mockContactDao,
      transactionWebClient: mockWebClient,
    ));

    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    await clickOnTheTransferMinicard(tester);

    verify(mockContactDao.findAll()).called(1);

    final contactList = find.byType(ContactToTransferList);
    expect(contactList, findsOneWidget);

    await clickOnTheFabNew(tester);

    final contactForm = find.byType(ContactForm);
    expect(contactForm, findsOneWidget);

    await fillTextWithTextLabel(tester, text: 'Alex', labelText: 'Full name');
    await fillTextWithTextLabel(tester, text: '1000', labelText: 'Account number');
    await clickOnTheButtonWithText(tester, 'Create');

    verify(mockContactDao.save(new Contact(0, 'Alex', 1000))).called(1);

    verify(mockContactDao.findAll()).called(1);
    final contactListBack = find.byType(ContactToTransferList);
    expect(contactListBack, findsOneWidget);
    
  });
}




