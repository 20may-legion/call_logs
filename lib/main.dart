import 'dart:developer';

import 'package:call_log/call_log.dart';
import 'package:call_logs/Contacts.dart';
import 'package:call_logs/MaxCalls.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

import 'COntactList.dart';
import 'CallLogs.dart';

void main() {
  runApp(const MyApp());
}

TextEditingController search_controller = TextEditingController();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

Iterable<CallLogEntry> _callLogEntries = <CallLogEntry>[];

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('call_log example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ContactListPage()));
              },
              child: Text("See Contacts"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CallLogs(
                          name: "",
                        )));
              },
              child: Text("See logs"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => MaxCalls()));
              },
              child: Text("Max Calls"),
            ),
          ],
        ),
      ),
    );
  }
}
