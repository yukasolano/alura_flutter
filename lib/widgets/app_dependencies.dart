import 'package:alura_flutter/http/webclients/transaction_webclient.dart';
import 'package:flutter/material.dart';

import '../database/dao/contacts_dao.dart';

class AppDependencies extends InheritedWidget {
  final ContactDao contactDao;
  final TransactionWebClient transactionWebClient;

  AppDependencies(
      {required this.contactDao,
      required this.transactionWebClient,
      required Widget child})
      : super(child: child);

  static AppDependencies? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppDependencies>();
  }

  @override
  bool updateShouldNotify(AppDependencies oldWidget) {
    return contactDao != oldWidget.contactDao ||
        transactionWebClient != oldWidget.transactionWebClient;
  }
}
