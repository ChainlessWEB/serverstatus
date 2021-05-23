import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:serverstatus/view/home_page.dart';

void main() {
  runApp(ServerStatusApp());
}

class ServerStatusApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Server Status';
    initializeDateFormatting('it_IT', null);
    return MaterialApp(
      title: appTitle,
      home: HomePage(title: appTitle)
    );
  }
}

