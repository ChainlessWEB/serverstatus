import 'package:flutter/material.dart';
import 'package:serverstatus/domain/server.dart';

import 'server_details.dart';

class ServerList extends StatelessWidget {
  final List<Server> serverStatuses;

  ServerList({Key? key, required this.serverStatuses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: serverStatuses.length,
      itemBuilder: (context, index) {
        final item = serverStatuses[index];
        return ListTile(
          title: item.buildServerName(context),
          subtitle: item.buildCreatedAt(context),
          trailing: item.buildServerStatus(context),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ServerDetails(item)),
            );
          },
        );
      },
    );
  }
}
