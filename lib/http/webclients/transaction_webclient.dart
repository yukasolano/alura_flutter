import 'dart:convert';

import 'package:alura_flutter/models/transaction.dart';
import 'package:http/http.dart';

import '../webclient.dart';

class TransactionWebClient {
  final String host = '192.168.0.3:8080';
  final String endpoint = '/transactions';

  Future<List<Transaction>> findAll() async {
    final Response response = await client
        .get(Uri.http(host, endpoint))
        .timeout(Duration(seconds: 5));
    return _toTransactions(response);
  }

  Future<Transaction> save(Transaction transaction) async {
    print(transaction.toJson());
    final Response response = await client
        .post(Uri.http(host, endpoint),
            headers: {'Content-Type': 'application/json', 'password': '1000'},
            body: jsonEncode(transaction.toJson()))
        .timeout(Duration(seconds: 5));
    return Transaction.fromJson(jsonDecode(response.body));
  }

  List<Transaction> _toTransactions(Response response) {
    final List<dynamic> transactionsJson = jsonDecode(response.body);
    return transactionsJson.map((json) => Transaction.fromJson(json)).toList();
  }
}
