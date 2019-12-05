import 'package:flutter/material.dart';
import 'customDrawer.dart';

class OfferPage extends StatefulWidget {
  OfferPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _OfferPage createState() => _OfferPage();
}

class _OfferPage extends State<OfferPage> {

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
