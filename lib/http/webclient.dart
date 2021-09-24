import 'dart:convert';

import 'package:alura_flutter/models/contact.dart';
import 'package:alura_flutter/models/transaction.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

Future<List<Transaction>> findAll() async {
  final Client client =
      InterceptedClient.build(interceptors: [LoggingInterceptor()]);

  final Response response = await client
      .get(Uri.http('192.168.0.3:8080', '/transactions'))
      .timeout(Duration(seconds: 5));
  final List<dynamic> transactionsJson = jsonDecode(response.body);
  final List<Transaction> transactions = [];
  for (Map<String, dynamic> transactionJson in transactionsJson) {
    final Map<String, dynamic> contactJson = transactionJson['contact'];
    transactions.add(Transaction(transactionJson['value'],
        Contact(0, contactJson['name'], contactJson['accountNumber'])));
  }
  print(transactionsJson);
  return transactions;
}

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    print('Request');
    print('url: ${data.url}');
    print('headers: ${data.headers}');
    print('body: ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print('Response');
    print('status code: ${data.statusCode}');
    print('headers: ${data.headers}');
    print('body: ${data.body}');
    return data;
  }
}
