import 'package:Dorfinventar/src/userModel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'customDrawer.dart';

class MyOffersPage extends StatefulWidget {
  MyOffersPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyOffersPage createState() => _MyOffersPage();
}

class _MyOffersPage extends State<MyOffersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: CustomDrawer(),
      body: _settingsWidget(),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          child: Text("+", style: TextStyle(fontSize: 32)),
          onPressed: () => showSnackbar(context),
          ),
        ),
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

  showSnackbar(BuildContext context) {
    Scaffold.of(context).showSnackBar(
        SnackBar(content: Text("Sending Message")));
  }
}
