import 'dart:convert';

import 'package:http/http.dart';

import '../webclient.dart';

const MESSAGE_URI =
    'https://gist.githubusercontent.com/yukasolano/a615fc0df9c9a0d9428d7c1bd78493b4/raw/ef0d8e2dd6d5e7a51203ffd948b5f5577b6e39a6/';

class I18NWebClient {
  final String _viewKey;

  I18NWebClient(this._viewKey);

  Future<Map<String, dynamic>> findAll() async {
    final Response response = await client.get("$MESSAGE_URI$_viewKey.json");
    final Map<String, dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson;
  }
}
