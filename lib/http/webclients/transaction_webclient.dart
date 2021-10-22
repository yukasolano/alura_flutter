import 'dart:convert';

import 'package:alura_flutter/models/transaction.dart';
import 'package:http/http.dart';

import '../webclient.dart';

class TransactionWebClient {
  final String host = '192.168.1.53:8080';
  final String endpoint = '/transactions';

  Future<List<Transaction>> findAll() async {
    final Response response = await client
        .get(Uri.http(host, endpoint))
        .timeout(Duration(seconds: 5));
    return _toTransactions(response);
  }

  Future<Transaction?> save(Transaction transaction, String password) async {
    print(transaction.toJson());
    final Response response = await client
        .post(Uri.http(host, endpoint),
            headers: {'Content-Type': 'application/json', 'password': password},
            body: jsonEncode(transaction.toJson()))
        .timeout(Duration(seconds: 5));

    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    }
    _throwHttpError(response.statusCode);
  }

  void _throwHttpError(int statusCode) {
    final String? error = _statusCodeResponses[statusCode];
    if (error == null) {
      throw Exception("unexpected error occurred");
    }
    throw Exception(_statusCodeResponses[statusCode]);
  }



  static final Map<int, String> _statusCodeResponses = {
    400: "error submitting transaction",
    401: "authentication error"
  };

  List<Transaction> _toTransactions(Response response) {
    final List<dynamic> transactionsJson = jsonDecode(response.body);
    return transactionsJson.map((json) => Transaction.fromJson(json)).toList();
  }
}
