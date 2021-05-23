import 'package:flutter/material.dart';
import 'package:serverstatus/domain/history.dart';
import 'package:serverstatus/domain/mock_utils.dart';
import 'package:serverstatus/domain/server.dart';
import 'package:serverstatus/service/server_status.service.dart';
import 'package:serverstatus/view/history_list.dart';

class ServerDetails extends StatelessWidget {
  Server server;

  ServerDetails(this.server);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Server Details"),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
          Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Server", style: TextStyle(fontSize: 18)),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(server.serverName, style: TextStyle(fontSize: 20)),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Status", style: TextStyle(fontSize: 18)),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(MockUtils.mapServerStatus(server.serverStatus).toString(),
              style: MockUtils.mapServerStatusColor(
                  MockUtils.mapServerStatus(server.serverStatus))),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Checking status...')));
              fetchServerStatus(server.id).then((value) {
                this.server = value;
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Check completed')));
              });
            },
            child: Text('Update'),
          ),
        ),
        FutureBuilder<List<History>>(
          future: fetchServerHistory(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? HistoryList(history: snapshot.data!)
                : Center(child: CircularProgressIndicator());
          },
        ),
      ]),
    );
  }
}
