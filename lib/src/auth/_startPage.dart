import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../userModel.dart';

/*  Start Page
      Gibt eine kurze Einführung in das Konzept der App

 */


class StartPage extends StatefulWidget {
  StartPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _StartPage createState() => _StartPage();
}

class _StartPage extends State<StartPage> {
  /* If StartPage was reached once, automatically go to /home */
  _init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool doNotRemind = prefs.getBool('dont_remind');
    if (doNotRemind != null && doNotRemind) {

      Navigator.pushNamed(context, "/login");
    } else {
      prefs.setBool('dont_remind', true);
    }
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _startPageWidget(),
    );
  }

  Widget _startPageWidget() {
    return ScopedModelDescendant <UserModel>(
        builder: (context, child, model) {
          return Center(
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  children: <Widget>[
                    Text(
                        "Willkommen zur Dorfinventar App. \n Hier können Sie bequem "
                            "mit ihren Nachbarn Artikel verwalten, verkaufen oder teilen."),
                    Spacer(),
                    RaisedButton(
                      onPressed: () async {
                        if (!await model.loginFromStorage(context)) {
                          Navigator.pushNamed(context, '/home');
                        }
                      },
                      child: Text("Weiter zur App"),
                    )
                  ],
                ),
              )
          );
        });
  }
}
