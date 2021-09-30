import 'dart:convert';

import 'package:alura_flutter/models/contact.dart';
import 'package:alura_flutter/models/transaction.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';


final Client client =
InterceptedClient.build(interceptors: [LoggingInterceptor()]);

const String host = '192.168.0.3:8080';
const String endpoint = '/transactions';

Future<List<Transaction>> findAll() async {

  final Response response = await client
      .get(Uri.http(host, endpoint))
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

Future<Transaction> save(Transaction transaction) async {

  String transactionJson = jsonEncode(
      {'value': transaction.value,
      'contact': {
        'name': transaction.contact.name,
        'accountNumber': 1000
      }
  });

  final Response response = await client
      .post(Uri.http(host, endpoint),
            headers: {'Content-Type': 'application/json', 'password': '1000'},
  body: transactionJson)
      .timeout(Duration(seconds: 5));

  final Map<String, dynamic> json = jsonDecode(response.body);

  final Map<String, dynamic> contactJson = json['contact'];
  return Transaction(json['value'],
        Contact(0, contactJson['name'], contactJson['accountNumber']));
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
