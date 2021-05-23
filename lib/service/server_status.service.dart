import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:serverstatus/domain/history.dart';
import 'package:serverstatus/domain/server.dart';

Future<http.Response> createServerStatus(String serverName) {
  return http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'serverStatus': serverName,
    }),
  );
}

Future<Server> fetchServerStatus(int serverId) async {
  final response = await http.get(Uri.parse(
      'https://mockend.com/ChainlessWEB/mock_api/servers/' +
          serverId.toString()));
  return compute(parseServerStatus, response.body);
}

Future<List<Server>> fetchServerStatuses() async {
  final response = await http
      .get(Uri.parse('https://mockend.com/ChainlessWEB/mock_api/servers'));
  return compute(parseServerStatuses, response.body);
}

Future<List<History>> fetchServerHistory() async {
  final response = await http.get(Uri.parse(
      'https://mockend.com/ChainlessWEB/mock_api/history?limit=10&createdAt_order=desc'));
  return compute(parseServerHistory, response.body);
}

Server parseServerStatus(String responseBody) {
  return Server.fromJson(jsonDecode(responseBody));
}

List<Server> parseServerStatuses(String responseBody) {
  return jsonDecode(responseBody)
      .cast<Map<String, dynamic>>()
      .map<Server>((json) => Server.fromJson(json))
      .toList();
}

List<History> parseServerHistory(String responseBody) {
  return jsonDecode(responseBody)
      .cast<Map<String, dynamic>>()
      .map<History>((json) => History.fromJson(json))
      .toList();
}
