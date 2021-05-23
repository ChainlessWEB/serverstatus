import 'package:flutter/material.dart';
import 'package:serverstatus/domain/history.dart';

class HistoryList extends StatelessWidget {
  final List<History> history;

  HistoryList({Key? key, required this.history}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      shrinkWrap: true,
      itemCount: history.length,
      itemBuilder: (context, index) {
        final item = history[index];
        return ListTile(
            title: item.buildServerStatus(context),
            subtitle: item.buildCreatedAt(context));
      },
    ));
  }
}
