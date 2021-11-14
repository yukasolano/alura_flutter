import 'package:alura_flutter/database/dao/contacts_dao.dart';
import 'package:alura_flutter/http/webclients/transaction_webclient.dart';
import 'package:mockito/mockito.dart';

class MockContactDao extends Mock implements ContactDao {}
class MockTransactionWebClient extends Mock implements TransactionWebClient {}
