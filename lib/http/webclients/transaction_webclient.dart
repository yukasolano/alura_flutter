import 'dart:convert';

import 'package:alura_flutter/models/transaction.dart';
import 'package:http/http.dart';

import '../webclient.dart';

class TransactionWebClient {
  final String endpoint = '/transactions';

  Future<List<Transaction>> findAll() async {
    final Response response = await client
        .get(Uri.http(host, endpoint));
    return _toTransactions(response);
  }

  Future<Transaction?> save(Transaction transaction, String password) async {
    await Future.delayed(Duration(seconds: 2));

    final Response response = await client
        .post(Uri.http(host, endpoint),
            headers: {'Content-Type': 'application/json', 'password': password},
            body: jsonEncode(transaction.toJson()));

    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    }
    _throwHttpError(response.statusCode);
  }

  void _throwHttpError(int statusCode) {
    final String? error = _statusCodeResponses[statusCode];
    if (error == null) {
      throw HttpException("unexpected error occurred");
    }
    throw HttpException(error);
  }



  static final Map<int, String> _statusCodeResponses = {
    400: "error submitting transaction",
    401: "authentication error",
    409: 'transaction already exists'
  };

  List<Transaction> _toTransactions(Response response) {
    final List<dynamic> transactionsJson = jsonDecode(response.body);
    return transactionsJson.map((json) => Transaction.fromJson(json)).toList();
  }
}


class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
