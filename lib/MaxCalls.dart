import 'dart:developer';

import 'package:call_log/call_log.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CallLogs.dart';

class MaxCalls extends StatefulWidget {
  const MaxCalls({Key? key}) : super(key: key);

  @override
  State<MaxCalls> createState() => _MaxCallsState();
}

List<Contact>? _contacts;
Iterable<CallLogEntry> _callLogEntries = <CallLogEntry>[];

class _MaxCallsState extends State<MaxCalls> {
  @override
  void initState() {
    RunAlgorithm();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Max Calls',
          ),
        ),
        body: ListView.builder(
          itemCount: _contacts!.length,
          itemBuilder: (BuildContext context, int index) {
            Contact c = _contacts!.elementAt(index);
            return ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      CallLogs(name: c.displayName!),
                ));
              },
              leading: (c.avatar != null && c.avatar!.length > 0)
                  ? CircleAvatar(backgroundImage: MemoryImage(c.avatar!))
                  : CircleAvatar(child: Text(c.initials())),
              title: Text(c.displayName ?? ""),
            );
          },
        ));
  }

  void RunAlgorithm() async {
    await getAllContacts();
    await getAllCallLogs();
    findMaxCalls();
  }

  Future<void> getAllContacts() async {
    var contacts = (await ContactsService.getContacts(
      withThumbnails: false,
    ));
    setState(() {
      _contacts = contacts;
    });
  }

  Future<void> getAllCallLogs() async {
    _callLogEntries = await CallLog.get();
    setState(() {});
  }

  void findMaxCalls() async {
    Iterable<CallLogEntry> contactLOG = <CallLogEntry>[];
    log("call logs : ${_callLogEntries.length}");
    log("contacts : ${_contacts!.length}");

    for (var element in _contacts!) {
      contactLOG = await CallLog.query(name: element.displayName);
      log("name : ${element.displayName} and frequency : ${contactLOG.length}");
    }
  }
}
