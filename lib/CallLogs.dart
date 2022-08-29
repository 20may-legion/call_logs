import 'dart:developer';

import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';

import 'COntactList.dart';
import 'CallLogModel.dart';

List<String> sorting = ["Alphabetically", "Longest call", "Earliest"];
String sortingValue = sorting.first;
bool isReversed = false;

class CallLogs extends StatefulWidget {
  final String name;

  const CallLogs({Key? key, required this.name}) : super(key: key);

  @override
  State<CallLogs> createState() => _CallLogsState();
}

TextEditingController search_controller = TextEditingController();
Iterable<CallLogEntry> _callLogEntries = <CallLogEntry>[];
List<CallLogModel> _callLogList = <CallLogModel>[];

class _CallLogsState extends State<CallLogs> {
  @override
  void initState() {
    getCallLogsearch(widget.name);
    super.initState();
  }

  @override
  void dispose() {
    _callLogEntries = [];
    _callLogList = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Call logs',
            ),
            IconButton(
                onPressed: () {
                  isReversed = !isReversed;
                  _callLogList = _callLogList.reversed.toList();
                  setState(() {});
                },
                icon: isReversed
                    ? Icon(Icons.arrow_upward)
                    : Icon(Icons.arrow_downward)),
            DropdownButton(
                dropdownColor: Theme.of(context).primaryColor,
                value: sortingValue,
                items: sorting.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(
                      items,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  sortingValue = value.toString();
                  setState(() {});
                  sortData(sortingValue);
                }),
          ],
        ),
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(hintText: "search by name"),
            controller: search_controller,
            onChanged: (value) {
              getCallLogsearch(value);
              setState(() {});
            },
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (contex, index) {
                var entry = _callLogList[index];
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: <Widget>[
                      Divider(),
                      Text(
                        'F. NUMBER: ${entry.formattedNumber}',
                      ),
                      Text(
                        'NUMBER   : ${entry.number}',
                      ),
                      Text(
                        'NAME     : ${entry.name}',
                      ),
                      Text(
                        'TYPE     : ${entry.callType.toString().split(".").elementAt(1)}',
                        style: TextStyle(
                          color: ((entry.callType == CallType.incoming)
                              ? Colors.green
                              : Colors.red),
                        ),
                      ),
                      Text(
                        'DATE     : ${DateTime.fromMillisecondsSinceEpoch(entry.timestamp!)}',
                      ),
                      Text(
                        'DURATION :  ${entry.duration}',
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                  ),
                );
              },
              itemCount: _callLogList.length,
            ),
          ),
        ],
      ),
    );
  }

  getCallLogs() async {
    _callLogEntries = await CallLog.get();

    log("call logs : ${_callLogEntries.length}");
    setState(() {});
    return _callLogEntries;
  }

  getCallLogsearch(String keyword) async {
    log("keyword $keyword");
    keyword != ""
        ? _callLogEntries = await CallLog.query(name: keyword)
        : _callLogEntries = await CallLog.get();
    // _callLogList = _callLogEntries.toList();
    log("call logs : ${_callLogEntries.length}");
    _callLogEntries.forEach((element) {
      CallLogModel newLog = CallLogModel(
          element.name ?? "",
          element.number,
          element.formattedNumber,
          element.callType,
          element.duration,
          element.timestamp,
          element.cachedNumberType,
          element.cachedNumberLabel,
          element.cachedMatchedNumber,
          element.simDisplayName,
          element.phoneAccountId);
      _callLogList.add(newLog);
    });

    // for (int i = 0; i < 20; i++) {
    //   _callLogList.add(_callLogEntries.elementAt(i));
    // }

    setState(() {});
    return _callLogEntries;
  }

  void sortData(String value) {
    switch (value) {
      case "Alphabetically":
        _callLogList.sort((a, b) => a.name!.compareTo(b.name!));
        break;
      case "Longest call":
        _callLogList.sort((a, b) => b.duration!.compareTo(a.duration!));
        break;
      case "Earliest":
        _callLogList.sort((a, b) => b.timestamp!.compareTo(a.timestamp!));
        break;
    }

    setState(() {});
  }
}
