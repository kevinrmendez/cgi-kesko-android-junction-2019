import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int _counter = 0;
  String token;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  void firebaseCloudMessagingListeners() {
    _firebaseMessaging.getToken().then((token) {
      print(token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
    _firebaseMessaging.getToken().then((token) {
      print(" TOKEN : $token");
    });
  }

  Future<String> _getToken() {
    var token = _firebaseMessaging.getToken();
    return token;
  }

  @override
  void initState() {
    firebaseCloudMessagingListeners();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("APP")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'DEVICE TOKEN',
              style: TextStyle(fontSize: 30),
            ),
            FutureBuilder<String>(
              future:
                  _getToken(), // a previously-obtained Future<String> or null
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Text('Press button to start.');
                  case ConnectionState.active:
                  case ConnectionState.waiting:
                    return Text('Awaiting result...');
                  case ConnectionState.done:
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SelectableText(
                        '${snapshot.data}',
                        style: TextStyle(fontSize: 20),
                      ),
                    );
                }
                return null; // unreachable
              },
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
