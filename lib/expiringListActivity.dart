import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ExpiringListActivity extends StatefulWidget {
  ExpiringListActivity({Key key}) : super(key: key);

  @override
  _ExpiringListActivityState createState() => _ExpiringListActivityState();
}

class _ExpiringListActivityState extends State<ExpiringListActivity> {
  List<String> litems = ["1", "2", "Third", "4"];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Expiring List"),
        ),
        body: ListView.builder(
            itemCount: litems.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return new Text(litems[index]);
            })
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
