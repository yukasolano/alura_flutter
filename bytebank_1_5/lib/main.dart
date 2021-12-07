import 'package:alura_flutter/components/name.dart';
import 'package:alura_flutter/http/webclients/transaction_webclient.dart';
import 'package:alura_flutter/screens/dashboard.dart';
import 'package:alura_flutter/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';


import 'components/bytebank_theme.dart';
import 'database/dao/contacts_dao.dart';

void main() {
  runApp(ByteBankApp(
    contactDao: ContactDao(),
    transactionWebClient: TransactionWebClient(),
  ));
}

class ByteBankApp extends StatelessWidget {
  final ContactDao contactDao;
  final TransactionWebClient transactionWebClient;

  const ByteBankApp(
      {required this.contactDao, required this.transactionWebClient});

  @override
  Widget build(BuildContext context) {
    return AppDependencies(
      contactDao: contactDao,
      transactionWebClient: transactionWebClient,
      child: MaterialApp(
        theme: bytebankTheme,
        home: NameContainer()//Dashboard(),
      ),
    );
  }
}
