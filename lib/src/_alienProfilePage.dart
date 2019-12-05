import 'package:flutter/material.dart';
import 'customDrawer.dart';

class AlienProfilePage extends StatefulWidget {
  AlienProfilePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AlienProfilePage createState() => _AlienProfilePage();
}

class _AlienProfilePage extends State<AlienProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: CustomDrawer(),
      body: _settingsWidget(),
    );
  }


  Widget _settingsWidget() {
    return Column(
      children: <Widget>[
        RaisedButton(
          onPressed: () => Navigator.pushNamed(context, "/home"),
          child: Text("Login"),
        ),
        RaisedButton(
          onPressed: () => Navigator.pushNamed(context, "/register"),
          child: Text("Registrieren"),
        ),
      ],
    );
  }
}
