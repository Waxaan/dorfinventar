import 'package:flutter/material.dart';

/*  Login Page
      Nur die Login-Seite der App
      Zeigt dem User eine Seite mit Login, Passwort und einer Möglichkeit sich
      neu zu registrieren

 */

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title, this.loggedIn}) : super(key: key);
  final String title;
  bool loggedIn;


  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _loginWidget(),
    );
  }


  Widget _loginWidget() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                  labelText: "Benutzername"
              ),),
            TextFormField( obscureText: true,
              decoration: InputDecoration(
                  labelText: "Passwort"
              ),),
            RaisedButton(
                onPressed: () => Navigator.pushNamed(context, "/home"),
                child: Text("Login"),
            ),
            RaisedButton(
                onPressed: () => Navigator.pushNamed(context, "/register"),
                child: Text("Registrieren"),
            ),
          ],
        ),
      ),
    );
  }
}
