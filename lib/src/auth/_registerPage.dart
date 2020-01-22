import 'package:flutter/material.dart';
import '../customDrawer.dart';


/*  Register Page
      Zeigt dem User eine Seite mit Login, Passwort und anderen Einstellungen,
      die zu beginn gesetzt werden können.

 */

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _settingsWidget(),
    );
  }


  Widget _settingsWidget() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          children: <Widget>[
            Text("Vielen Dank für Ihre Entscheidung sich bei uns zu registrieren"),
            TextFormField( decoration: InputDecoration(
                labelText: "Benutzername"
            ),),
            TextFormField( decoration: InputDecoration(
                labelText: "E-Mail"
            ),),
            TextFormField( obscureText: true,
              decoration: InputDecoration(
                  labelText: "Passwort"
              ),),
            TextFormField( obscureText: true,
              decoration: InputDecoration(
                  labelText: "Passwort bestätigen"
              ),),
            RaisedButton(
               onPressed: () => Navigator.pushNamed(context, "/login"),
               child: Text("Registrieren"),
            ),
          ],
        ),
      ),
    );
  }
}
