import 'package:flutter/material.dart';
import 'package:serverstatus/domain/server.dart';
import 'package:serverstatus/service/server_status.service.dart';
import 'package:serverstatus/view/server_list.dart';

class HomePage extends StatelessWidget {
  final String title;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  HomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: FutureBuilder<List<Server>>(
          future: fetchServerStatuses(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
                ? ServerList(serverStatuses: snapshot.data!)
                : Center(child: CircularProgressIndicator());
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => buildServerDialog(context),
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ));
  }

  Future<dynamic> buildServerDialog(BuildContext context) {
    RegExp ipRegExp = new RegExp(
        r'(^((25[0-5]|(2[0-4]|1[0-9]|[1-9]|)[0-9])(\.(?!$)|$)){4}$)');
    RegExp urlRegExp = new RegExp(
        r'(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})$');

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  right: -20.0,
                  top: -20.0,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.close),
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.black,
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 8.0, 0, 0),
                        child: Text("Server url or IP"),
                      ),
                      TextFormField(
                          autovalidateMode: AutovalidateMode.always,
                          controller: _controller,
                          validator: (value) => ipRegExp.hasMatch(value!) ||
                                  urlRegExp.hasMatch(value)
                              ? null
                              : 'Please use a valid format'),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              createServerStatus(_controller.text).then((res) {
                                if (res.statusCode == 201) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Server added successfully')));
                                  Navigator.of(context).pop();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Cannot add the server. Try again')));
                                }
                              });
                            }
                          },
                          child: Text('Add server'),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
