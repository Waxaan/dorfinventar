import 'package:flutter/material.dart';

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
              onPressed: () => Navigator.pushNamed(context, "/login"),
              child: Text("Weiter zum Login"),
            )
          ],
        ),
      )
    );
  }

}
