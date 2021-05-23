import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:serverstatus/domain/mock_utils.dart';

class History {
  final int serverStatus;
  final DateTime createdAt;

  History({required this.serverStatus, required this.createdAt});

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
        serverStatus: json['serverStatus'],
        createdAt: DateTime.parse(json['createdAt']));
  }

  Widget buildServerStatus(BuildContext context) =>
      Text(MockUtils.mapServerStatus(serverStatus).toString(),
          style: MockUtils.mapServerStatusColor(
              MockUtils.mapServerStatus(serverStatus)));

  Widget buildCreatedAt(BuildContext context) =>
      Text(new DateFormat('dd MMMM yyyy - HH:mm:ss').format(createdAt));
}
