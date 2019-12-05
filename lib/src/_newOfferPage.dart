import 'package:flutter/material.dart';
import 'customDrawer.dart';

class NewOfferPage extends StatefulWidget {
  NewOfferPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _NewOfferPage createState() => _NewOfferPage();
}

class _NewOfferPage extends State<NewOfferPage> {

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
