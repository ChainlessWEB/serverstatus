
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:serverstatus/domain/mock_utils.dart';

class Server {
  final int id;
  final String serverName;
  final int serverStatus;
  final DateTime createdAt;

  Server(
      {required this.id,
      required this.serverName,
      required this.serverStatus,
      required this.createdAt});

  factory Server.fromJson(Map<String, dynamic> json) {
    return Server(
        id: json['id'],
        serverName: json['serverName'],
        serverStatus: json['serverStatus'],
        createdAt: DateTime.parse(json['createdAt']));
  }

  Widget buildServerName(BuildContext context) => Text(serverName);

  Widget buildServerStatus(BuildContext context) =>
      Text(MockUtils.mapServerStatus(serverStatus).toString(),
          style: MockUtils.mapServerStatusColor(
              MockUtils.mapServerStatus(serverStatus)));

  Widget buildCreatedAt(BuildContext context) => Text("Added on " +
      new DateFormat('dd MMMM yyyy - HH:mm:ss').format(createdAt));
}
