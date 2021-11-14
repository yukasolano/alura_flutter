import 'package:alura_flutter/main.dart';
import 'package:alura_flutter/models/contact.dart';
import 'package:alura_flutter/screens/dashboard.dart';
import 'package:alura_flutter/screens/transfers_web/contact_to_transfer_list.dart';
import 'package:alura_flutter/screens/transfers_web/transaction_form.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../helpers/mocks.dart';
import 'actions.dart';

void main() {
  testWidgets('Should transfer to a contact', (tester) async {
    final mock = MockContactDao();
    await tester.pumpWidget(ByteBankApp(contactDao: mock));

    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    when(mock.findAll()).thenAnswer((realInvocation) async {
      return [new Contact(0, 'Alex', 1000)];
    });

    await clickOnTheTransferMinicard(tester);
    await tester.pumpAndSettle();

    verify(mock.findAll()).called(1);

    final contactList = find.byType(ContactToTransferList);
    expect(contactList, findsOneWidget);

    final contactItem = find.byWidgetPredicate((widget) {
      if(widget is ContactItem) {
        return widget.contact.name == 'Alex' && widget.contact.accountNumber == 1000;
      }
      return false;
    });
    expect(contactItem, findsOneWidget);
    await tester.tap(contactItem);
    await tester.pumpAndSettle();

    final transactionForm = find.byType(TransactionForm);
    expect(transactionForm, findsOneWidget);
  });
}
